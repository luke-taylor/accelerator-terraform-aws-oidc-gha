output "repository_clone_url" {
  description = "Git clone URL (HTTPS)"
  value       = github_repository.this.http_clone_url
}

output "repository_full_name" {
  description = "Full name of the repository (owner/repo)"
  value       = github_repository.this.full_name
}

output "repository_ssh_url" {
  description = "Git clone URL (SSH)"
  value       = github_repository.this.ssh_clone_url
}

output "repository_url" {
  description = "URL of the created GitHub repository"
  value       = github_repository.this.html_url
}
