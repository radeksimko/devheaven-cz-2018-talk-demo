provider "aws" {
  region = "eu-west-3"
  profile = "tf"
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "radek-devheaven-tfstate"
  acl    = "private"
}

resource "aws_s3_bucket" "lambda" {
  bucket = "radek-devheaven-lambda"
  acl    = "private"
}

output "tfstate_bucket_name" {
  value = "${aws_s3_bucket.tfstate.bucket}"
}

output "lambda_bucket_name" {
  value = "${aws_s3_bucket.lambda.bucket}"
}
