# Lambda用IAMロールの作成
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

# CodePipeline用IAMロールの作成
module "codepipeline_iam_role" {
  source = "../modules/iam_role"

  role_name = "codepipeline-execution-role"
  assume_role_services = ["codepipeline.amazonaws.com"]
  policy_actions = [
    "s3:GetObject",
    "s3:PutObject",
    "codebuild:StartBuild",
    "codebuild:BatchGetBuilds"
  ]
}


