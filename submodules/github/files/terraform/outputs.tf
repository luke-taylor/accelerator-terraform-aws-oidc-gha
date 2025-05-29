# Add your outputs here

output "example_bucket_arn" {
  description = "ARN of the example S3 bucket"
  value       = aws_s3_bucket.example.arn
}
