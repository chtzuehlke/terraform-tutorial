provider "aws" {
    version = "~> 2.0"
    region  = "eu-central-1"
}

terraform {
    backend "s3" {
        bucket = "terraformchtzbucket"
        key    = "multiaccount/b/terraform.tfstate"
        region = "eu-central-1"
    }
}
