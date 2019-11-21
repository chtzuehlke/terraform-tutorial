provider "aws" {
    version = "~> 2.0"
    region  = "eu-west-1"
}

terraform {
    backend "s3" {
        bucket = "terraformchtzbucket"
        key    = "multiaccount/a/terraform.tfstate"
        region = "eu-central-1"
    }
}
