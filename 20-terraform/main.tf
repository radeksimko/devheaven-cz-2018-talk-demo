provider "aws" {
  region = "${var.aws_region}"
  profile = "tf"
}

terraform {
  backend "s3" {
    profile = "tf"
    bucket = "radek-devheaven-tfstate"
    key    = "terraform.tfstate"
    region = "eu-west-3"
  }
}
