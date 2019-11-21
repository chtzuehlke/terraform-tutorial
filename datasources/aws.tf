variable "myregion" {
    type = string
}

provider "aws" {
    version = "~> 2.0"
    region  = var.myregion
}

terraform {
    backend "s3" {
        bucket = "terraformchtzbucket"
        key    = "datasources/terraform.tfstate"
        region = "eu-central-1"
    }
}
