variable "aws_access_key" {
  type        = string
  description = "AWS access key"
  sensitive   = true
}

variable "aws_secret_key" {
  type        = string
  description = "AWS secret key"
  sensitive   = true
}

variable "github_owner" {
  type        = string
  description = "GitHub owner (username or organization)"
}

variable "github_token" {
  type        = string
  description = "GitHub token with repo permissions"
  sensitive   = true
}

variable "repository_name" {
  type        = string
  default     = "terraform-aws-oidc-deployment"
  description = "Name of the GitHub repository to create"
}
