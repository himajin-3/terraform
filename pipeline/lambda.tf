/*
resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  role          = module.lambda_iam_role.role_arn
  handler       = "index.handler"
  runtime       = "python3.9"
  filename      = "lambda_function.zip"
  #source_code_hash = filebase64sha256("lambda_function.zip")

  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }
}
*/