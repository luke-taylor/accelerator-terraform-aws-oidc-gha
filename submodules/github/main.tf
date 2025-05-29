resource "github_repository" "this" {
  name                   = var.repository_name
  description            = var.repository_description
  visibility             = var.repository_visibility
  auto_init              = true
  has_issues             = true
  has_projects           = false
  has_wiki               = false
  delete_branch_on_merge = true
  allow_merge_commit     = true
  allow_squash_merge     = true
  allow_rebase_merge     = false

  dynamic "security_and_analysis" {
    for_each = var.repository_visibility == "public" ? [1] : []
    content {
      secret_scanning {
        status = "enabled"
      }
      secret_scanning_push_protection {
        status = "enabled"
      }
    }
  }
}

resource "github_branch_protection" "this" {
  count = var.repository_visibility == "public" ? 1 : 0

  repository_id  = github_repository.this.node_id
  pattern        = var.default_branch
  enforce_admins = false

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = false
    required_approving_review_count = 1
  }

  required_status_checks {
    strict   = true
    contexts = ["Terraform"]
  }
}

resource "github_actions_variable" "this" {
  for_each = local.actions_variables

  repository    = github_repository.this.name
  variable_name = each.key
  value         = each.value
}

resource "github_repository_file" "this" {
  for_each = local.all_files

  repository          = github_repository.this.name
  branch              = var.default_branch
  file                = each.key
  commit_message      = "Add ${each.key} [skip ci]"
  overwrite_on_create = true
  content             = each.value.content
}
