# Lambda用IAMロールの作成
/*
module "lambda_iam_role" {
  source = "../modules/iam_role"

  role_name = "lambda-execution-role"
  assume_role_services = ["lambda.amazonaws.com"]
  policy_actions = [
    "logs:CreateLogGroup",
    "logs:CreateLogStream",
    "logs:PutLogEvents",
    "s3:GetObject"
  ]
}
*/
# CodePipeline用IAMロールの作成
module "codepipeline_iam_role" {
  source = "../modules/iam_role"

  role_name = "codepipeline-execution-role"
  assume_role_services = ["codepipeline.amazonaws.com"]
  policy_actions = [
    "s3:GetObject",
    "s3:PutObject",
    "codebuild:StartBuild",
    "codebuild:BatchGetBuilds",
#    "sts:AssumeRole"
  ]
}

# CodePipeline用IAMロールの作成
module "codebuild_iam_role" {
  source = "../modules/iam_role"

  role_name = "codebuild-execution-role"
  assume_role_services = ["codebuild.amazonaws.com"]
  policy_actions = [
    "logs:CreateLogGroup",    # CloudWatch Logsグループの作成権限
    "logs:CreateLogStream",   # CloudWatch Logsストリームの作成権限
    "logs:PutLogEvents",      # CloudWatch Logsにログを出力する権限
    "s3:GetObject",           # S3からオブジェクトを取得
    "s3:PutObject",           # S3にオブジェクトをアップロード
    "codebuild:StartBuild",   # CodeBuildのビルドを開始
    "codebuild:BatchGetBuilds" # CodeBuildのビルドステータスを取得
  ]
}
