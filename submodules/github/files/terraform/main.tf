# Add your AWS resources here

resource "aws_s3_bucket" "example" {
  bucket_prefix = "example-bucket-"

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}
