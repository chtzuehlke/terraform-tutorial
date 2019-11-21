# Terraform tutorial

## Provider and backend config

see aws.tf
see terraform.tfvars 

## Provisioning script

see main.tf

Command:

    aws s3api create-bucket --bucket dev-chtz-testbucket-c --create-bucket-configuration LocationConstraint=eu-central-1

    terraform apply

Output:

    ...
    bucket_arn = arn:aws:s3:::dev-chtz-testbucket-c
