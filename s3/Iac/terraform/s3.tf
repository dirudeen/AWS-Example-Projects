resource "aws_s3_bucket" "my-test-bucket-diru" {
  bucket = "test-bucket-diru-deen"

  tags = {
    Environment = "Dev"
  }
}