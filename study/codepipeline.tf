resource "aws_codepipeline" "my_pipeline" {
  name     = "MyCodePipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = "codepipeline-study-kamiguchi"
    type     = "S3"
  }

  depends_on = ["codepipeline-study-kamiguchi"]

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        S3Bucket    = "codepipeline-study-kamiguchi"
        S3ObjectKey = "source.zip"
      }
    }
  }

  stage {
    name = "InvokeLambda"

    action {
      name             = "InvokeLambda"
      category         = "Invoke"
      owner            = "AWS"
      provider         = "Lambda"
      input_artifacts  = ["source_output"]
      version          = "1"

      configuration = {
        FunctionName = aws_lambda_function.my_lambda.function_name
      }
    }
  }
}
