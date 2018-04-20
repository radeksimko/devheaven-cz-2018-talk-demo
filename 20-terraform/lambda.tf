resource "aws_lambda_function" "example" {
  function_name = "${var.prefix}-example"

  s3_bucket = "${var.s3_bucket}"
  s3_key    = "${var.s3_key}"

  handler = "main"
  runtime = "go1.x"

  role = "${aws_iam_role.lambda.arn}"
}

resource "aws_iam_role" "lambda" {
  name = "${var.prefix}-lambda"

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

resource "aws_iam_role_policy" "lambda" {
  name = "allow_cloudwatch"
  role = "${aws_iam_role.lambda.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
