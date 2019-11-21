data "aws_s3_bucket" "existing_bucket" {
    bucket = "dev-chtz-testbucket-c"
}

resource "aws_s3_bucket_public_access_block" "bucket_nonpublic" {
  bucket = data.aws_s3_bucket.existing_bucket.id
  block_public_acls   = true
}

output "bucket_arn" {
    value = data.aws_s3_bucket.existing_bucket.arn
}
