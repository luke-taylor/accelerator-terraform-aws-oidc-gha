data "tls_certificate" "this" {
  url = "https://token.actions.githubusercontent.com"
}

data "aws_caller_identity" "this" {}
