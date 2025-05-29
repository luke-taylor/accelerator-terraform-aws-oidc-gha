locals {
  actions_variables = {
    "AWS_REGION"      = var.aws_region
    "AWS_ROLE_ARN"    = "arn:aws:iam::${var.aws_account_id}:role/${var.oidc_role_name}"
    "TF_STATE_BUCKET" = var.s3_state_bucket_name
  }
  all_files = merge(
    {
      for file in local.static_files : file => {
        content = file("${path.module}/files/${file}")
      }
    },
    {
      for file in local.template_files : trimsuffix(file, ".tftpl") => {
        content = templatefile("${path.module}/files/${file}", local.template_vars)
      }
    }
  )
  static_files = setsubtract(
    fileset("${path.module}/files", "**"),
    fileset("${path.module}/files", "**/*.tftpl")
  )
  template_files = fileset("${path.module}/files", "**/*.tftpl")
  template_vars = {
    s3_state_bucket_name   = var.s3_state_bucket_name
    aws_region             = var.aws_region
    repository_name        = var.repository_name
    repository_description = var.repository_description
  }
}
