resource "aws_lambda_function" "my_lambda" {
  function_name = "test"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"  # Lambdaのエントリーポイント
  runtime       = "python3.9

  filename         = "test"  # ローカルファイル（LambdaコードのZipファイル）
  # source_code_hash = filebase64sha256("lambda_function_payload.zip")  # ファイルのハッシュで変更を検知

  environment {
    variables = {
      ENV_VAR_1 = "value1"
      ENV_VAR_2 = "value2"
    }
  }
}
