provider "aws" {
  region = "${var.aws_region}"
  profile = "tf"
}

resource "aws_lambda_function" "example" {
  function_name = "radek-devheaven-example"

  s3_bucket = "radek-devheaven-lambda"
  s3_key    = "deployment.zip"

  handler = "main.handler"
  runtime = "go1.x"

  role = "${aws_iam_role.lambda.arn}"
}

resource "aws_iam_role" "lambda" {
  name = "radek-devheaven-example"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
