terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {}


resource "aws_s3_bucket" "default" {
  bucket = "test-bucket-diru-123"

}

resource "aws_s3_object" "file" {
  bucket = aws_s3_bucket.default.bucket
  key = "hello.txt"
  source = "hello.txt"
  etag = filemd5("hello.txt")
  content_type = "plain/text"
}

