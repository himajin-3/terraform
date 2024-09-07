# AWS ChatbotのSlackチャンネル設定を作成するリソース
resource "awscc_chatbot_slack_channel_configuration" "this" {
  # Slackチャンネル設定の名前
  configuration_name = "terraform-slack-channel-config"

  # Chatbotが使用するIAMロールのARN
  iam_role_arn = awscc_iam_role.this.arn

  # 通知を送るSlackのチャンネルID
  slack_channel_id = "C06CRP8EYHH"

  # SlackのワークスペースID (AWS Chatbotのコンソール画面で事前に設定が必要)
  slack_workspace_id = "T052RBT95S5"

  # 通知を送るSNSトピックのARNのリスト
  sns_topic_arns = [aws_sns_topic.this.arn]
}

# Chatbotが使用するIAMロールを作成するリソース
resource "awscc_iam_role" "this" {
  # IAMロールの名前
  role_name = "Terraform-ChatBot-Channel-Role"

  # このポリシーはChatbotサービスがこのロールを引き受けることを許可する
  assume_role_policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "chatbot.amazonaws.com"
        }
      },
    ]
  })

  # このロールにアタッチする管理ポリシーのARN
  managed_policy_arns = ["arn:aws:iam::aws:policy/AWSResourceExplorerReadOnlyAccess"]
}

# AWSの通知を送るSNSトピックを作成するリソース
resource "aws_sns_topic" "this" {
  # SNSトピックの名前
  name = "terraform-sns-topic"
}


