variable "bucket_suffix" {
    type = string
}

locals {
  common_tags = {
      TFWorkspace = terraform.workspace
  }
}

resource "aws_s3_bucket" "samplebucket" {
    bucket = "${terraform.workspace}-${var.bucket_suffix}"

    tags = merge(local.common_tags, { 
        Suffix : var.bucket_suffix
    })
}

resource "aws_s3_bucket_public_access_block" "samplebucket_nonpublic" {
  bucket = aws_s3_bucket.samplebucket.id
  block_public_acls   = true
}

output "bucket" {
    value = aws_s3_bucket.samplebucket.id
}
