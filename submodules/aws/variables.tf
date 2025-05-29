variable "github" {
  type = object({
    owner            = string
    repository_name  = string
    allowed_subjects = list(string)
  })
  description = "GitHub configuration for OIDC"
}

variable "iam" {
  type = object({
    role_name      = string
    policy_name    = string
    policy_actions = list(string)
  })
  description = "IAM configuration for the OIDC role and policy"
}

variable "s3" {
  type = object({
    bucket_name   = string
    force_destroy = bool
  })
  description = "S3 configuration for Terraform state"
}
