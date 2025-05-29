resource "random_bytes" "this" {
  length = 4
}

module "aws" {
  source = "./submodules/aws"

  github = {
    owner           = var.github_owner
    repository_name = var.repository_name
    allowed_subjects = [
      "repo:${var.github_owner}/${var.repository_name}:*"
    ]
  }
  iam = {
    role_name   = "github-oidc-role"
    policy_name = "GitHubOIDCPolicy"
    policy_actions = [
      "ec2:*",
      "iam:*",
      "s3:*",
      "autoscaling:*",
      "cloudwatch:*",
      "logs:*",
      "sts:GetCallerIdentity"
    ]
  }
  s3 = {
    bucket_name   = "terraform-state-bucket-${random_bytes.this.hex}"
    force_destroy = true
  }
}

module "github" {
  source = "./submodules/github"

  aws_account_id        = module.aws.account_id
  aws_region            = "eu-north-1"
  github_owner          = var.github_owner
  oidc_role_name        = module.aws.oidc_role_name
  repository_name       = var.repository_name
  repository_visibility = "private"
  s3_state_bucket_name  = module.aws.s3_bucket_name
}
