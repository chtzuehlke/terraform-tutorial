data "aws_region" "current" {}

resource "aws_s3_bucket" "samplebucket" {
    bucket = "chtz-testbucket-${data.aws_region.current.name}"
}
