provider "aws" {
  region = "ap-northeast-1"
}

# S3バケットの作成（デプロイ先）
resource "aws_s3_bucket" "codepipeline_deploy" {
  bucket = "lambda-kamiguchi"
}

# CodeBuildプロジェクトの作成
resource "aws_codebuild_project" "build_project" {
  name          = "s3-deploy-build"
  service_role  = module.codebuild_iam_role.role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("../buildspec/buildspec.yml")
  }
}

# CodePipelineの作成
resource "aws_codepipeline" "my_pipeline" {
  name     = "github-to-s3-pipeline"
  role_arn = module.codepipeline_iam_role.role_arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_deploy.bucket
  }

  # GitHubをソースにするステージ
  stage {
    name = "Source"
    action {
      name             = "GitHub_Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner      = var.github_owner
        Repo       = var.github_repo
        Branch     = var.github_branch
        OAuthToken = var.github_token
      }
    }
  }

  # ビルドステージでZIPを作成
  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.build_project.name
      }
    }
  }

  # 複数のLambda用のZIPをS3にデプロイするステージ
  stage {
    name = "Deploy"

    dynamic "action" {
      for_each = var.lambda_functions
      content {
        name             = "S3_Deploy_${action.value.name}"
        category         = "Deploy"
        owner            = "AWS"
        provider         = "S3"
        version          = "1"
        input_artifacts  = ["build_output"]
        configuration = {
          BucketName  = aws_s3_bucket.codepipeline_deploy.bucket
          Extract     = "false"
          ObjectKey   = "${action.value.name}.zip"  # 各関数のZIPファイル名を動的に設定
        }
      }
    }
  }
}
