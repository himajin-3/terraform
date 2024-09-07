# S3バケット名
variable "bucket_name" {
  description = "S3バケットの名前"
  type        = string
}

# アクセス制御リスト (ACL)
variable "acl" {
  description = "S3バケットのACL (例: private, public-read, etc.)"
  type        = string
  default     = "private"
}

# バージョニング設定
variable "versioning" {
  description = "S3バケットのバージョニングを有効にするか"
  type        = bool
  default     = false
}

# 暗号化アルゴリズム
variable "sse_algorithm" {
  description = "S3バケットのサーバーサイド暗号化アルゴリズム (例: AES256)"
  type        = string
  default     = "AES256"
}

# ロギング設定
variable "logging_bucket" {
  description = "S3バケットのログの保存先"
  type        = string
  default     = null
}

variable "logging_prefix" {
  description = "S3バケットログのプレフィックス"
  type        = string
  default     = ""
}

# ライフサイクル設定
variable "lifecycle_enabled" {
  description = "ライフサイクルルールを有効にするか"
  type        = bool
  default     = false
}

variable "transition_days" {
  description = "データを別のストレージクラスに移行する日数"
  type        = number
  default     = 30
}

variable "storage_class" {
  description = "移行先のストレージクラス (例: STANDARD_IA, GLACIER)"
  type        = string
  default     = "GLACIER"
}

variable "expiration_days" {
  description = "オブジェクトの有効期限 (日数)"
  type        = number
  default     = 365
}

# バケットポリシー
variable "bucket_policy" {
  description = "S3バケットに適用するポリシー (JSONフォーマット)"
  type        = string
  default     = ""
}
