resource "aws_s3_bucket" "this" {
  bucket        = var.s3.bucket_name
  force_destroy = var.s3.force_destroy
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.amazonaws.com"]
  url             = "https://token.actions.githubusercontent.com"
  thumbprint_list = [data.tls_certificate.this.certificates[0].sha1_fingerprint]
}

data "aws_iam_policy_document" "this" {
  statement {
    actions   = var.iam.policy_actions
    effect    = "Allow"
    resources = ["*"]
    sid       = "TerraformPermissions"
  }
}

resource "aws_iam_policy" "this" {
  policy = data.aws_iam_policy_document.this.json
  name   = var.iam.policy_name
}

resource "aws_iam_role" "this" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.this.account_id}:oidc-provider/token.actions.githubusercontent.com"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          },
          StringLike = {
            "token.actions.githubusercontent.com:sub" = var.github.allowed_subjects
          }
        }
      }
    ]
  })
  name = var.iam.role_name
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.this.name
}
