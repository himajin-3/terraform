# GitHubのリポジトリオーナー名
variable "github_owner" {
  description = "GitHubリポジトリのオーナー名"
  type        = string
}

# GitHubのリポジトリ名
variable "github_repo" {
  description = "GitHubリポジトリの名前"
  type        = string
}

# GitHubリポジトリのブランチ名
variable "github_branch" {
  description = "GitHubリポジトリのブランチ名"
  type        = string
  default     = "main"
}

# GitHubのパーソナルアクセストークン
variable "github_token" {
  description = "GitHubのパーソナルアクセストークン"
  type        = string
  sensitive   = true  # センシティブな情報として扱う
}

