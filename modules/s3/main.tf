# S3バケットの作成
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  acl    = var.acl

  # バージョニング設定
  versioning {
    enabled = var.versioning
  }

  # サーバーサイド暗号化の設定
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.sse_algorithm
      }
    }
  }

  # ロギング設定 (オプション)
  logging {
    target_bucket = var.logging_bucket
    target_prefix = var.logging_prefix
  }

  # ライフサイクルルール (オプション)
  lifecycle_rule {
    enabled = var.lifecycle_enabled
    id      = "lifecycle-rule"

    transition {
      days          = var.transition_days
      storage_class = var.storage_class
    }

    expiration {
      days = var.expiration_days
    }
  }
}

# バケットポリシーの設定
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = var.bucket_policy
}
