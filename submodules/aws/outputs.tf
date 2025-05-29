output "account_id" {
  description = "AWS account ID from caller identity"
  value       = data.aws_caller_identity.this.account_id
}

output "oidc_role_arn" {
  description = "ARN of the IAM role for GitHub OIDC"
  value       = aws_iam_role.this.arn
}

output "oidc_role_name" {
  description = "Name of the IAM role for GitHub OIDC"
  value       = aws_iam_role.this.name
}

output "role" {
  value = aws_iam_role.this
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = aws_s3_bucket.this.bucket
}
