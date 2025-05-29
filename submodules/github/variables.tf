variable "aws_account_id" {
  type        = string
  description = "AWS account ID for OIDC role ARN"
}

variable "github_owner" {
  type        = string
  description = "GitHub owner (username or organization)"
}

variable "aws_region" {
  type        = string
  default     = "eu-north-1"
  description = "AWS region for OIDC configuration"
}

variable "default_branch" {
  type        = string
  default     = "main"
  description = "Default branch name"
}

variable "oidc_role_name" {
  type        = string
  default     = "github-oidc-role"
  description = "Name of the IAM role for GitHub OIDC"
}

variable "repository_description" {
  type        = string
  default     = "Terraform AWS OIDC Deployment"
  description = "Description of the GitHub repository"
}

variable "repository_name" {
  type        = string
  default     = "terraform-aws-oidc-deployment"
  description = "Name of the GitHub repository to create"
}

variable "repository_visibility" {
  type        = string
  default     = "public"
  description = "Visibility of the repository (public or private)"
}

variable "s3_state_bucket_name" {
  type        = string
  description = "S3 bucket name for Terraform state"
}
