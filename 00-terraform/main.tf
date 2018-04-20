provider "aws" {
  region = "eu-west-3"
  profile = "tf"
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.prefix}-tfstate"
  acl    = "private"
}

resource "aws_s3_bucket" "lambda" {
  bucket = "${var.prefix}-lambda"
  acl    = "private"
}

resource "aws_iam_user" "deployer" {
  name = "${var.prefix}-deployer"
}

resource "aws_iam_access_key" "deployer" {
  user = "${aws_iam_user.deployer.name}"
  pgp_key = "keybase:${var.keybase_user}"
}

resource "aws_iam_user_policy" "deployer" {
  name = "deployer"
  user = "${aws_iam_user.deployer.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.lambda.arn}/*"
    }
  ]
}
EOF
}

output "tfstate_bucket_name" {
  value = "${aws_s3_bucket.tfstate.bucket}"
}

output "lambda_bucket_name" {
  value = "${aws_s3_bucket.lambda.bucket}"
}

output "aws_access_key_id" {
  value = "${aws_iam_access_key.deployer.id}"
}

output "aws_access_key_secret" {
  value = "${aws_iam_access_key.deployer.encrypted_secret}"
}
# Decrypt via
# terraform output aws_access_key_secret | base64 -D - | gpg -d; echo
