resource "aws_s3_bucket" "samplebucket" {
    bucket = "${terraform.workspace}-${var.bucket_suffix}"
}

resource "aws_s3_bucket_public_access_block" "samplebucket_nonpublic" {
  count = var.block_public_acls ? 1 : 0
  bucket = aws_s3_bucket.samplebucket.id
  block_public_acls   = true
}
