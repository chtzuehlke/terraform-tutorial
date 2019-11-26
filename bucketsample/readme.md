# Terraform Tutorial

## Hello world (bucketsample)

### Preconditions

- AWS account
- AWS CLI installed
- Terraform installed
- Optional: jq installed

### AWS CLI configuration

Command:

    cat ~/.aws/config

Ouput:

    [profile terraformtutorial]
    region = eu-central-1
    output = json

Command:

    cat ~/.aws/credentials

Output:

    [terraformtutorial]
    aws_access_key_id = AKIASK5…
    aws_secret_access_key = 2S5i0OLi…

Command:

    export AWS_PROFILE=terraformtutorial

    aws s3api create-bucket --bucket terraformchtzbucket --create-bucket-configuration LocationConstraint=eu-central-1

### Module: backend and provider configuration

see aws.tf
    
### Module: provisioning script

see main.tf

### Module input

see development.tfvars 
see testing.tfvars 

### Module initialization

Commands:

    terraform init
    echo .terraform >> .gitignore
    
### Workspace creation

Commands:

    terraform workspace new dev
    terraform workspace show

Output:

    dev

Commands:

    terraform workspace new test
    cat .terraform/environment

Output:

    test

### Terraform apply

Commands:

    terraform workspace select dev
    terraform apply -var-file="development.tfvars" -auto-approve
    terraform output bucket

Ouptut:

    dev-chtz-testbucket

Commands:

    terraform workspace select test
    terraform apply -var-file="testing.tfvars" -auto-approve
    terraform output

Ouptut:

    bucket = test-chtz-othertestbucket

### Verify bucket creation

Command:

    aws s3api list-buckets --query "Buckets[].Name" --output json | grep chtz-

Ouptut:

    "dev-chtz-testbucket",
    "test-chtz-othertestbucket"

### Inspect terraform state file in S3

Command:

    aws s3 cp s3://terraformchtzbucket/env:/dev/bucketsample/terraform.tfstate /tmp/state --quiet && cat /tmp/state | jq ".outputs"

Ouptut:

    {
        "bucket": {
            "value": "dev-chtz-testbucket",
            "type": "string"
        }
    }

Command:

    aws s3 cp s3://terraformchtzbucket/env:/test/bucketsample/terraform.tfstate /tmp/state --quiet && cat /tmp/state | jq ".outputs"

Ouptut:

    {
        "bucket": {
            "value": "test-chtz-othertestbucket",
            "type": "string"
        }
    }

### Terraform destroy

Command:

    terraform workspace select dev
    terraform destroy -var="bucket_suffix=chtz-testbucket" -auto-approve
    
    terraform workspace select test
    terraform destroy -var="bucket_suffix=chtz-othertestbucket" -auto-approve

### Cleanup

Command:

    terraform workspace select default
    terraform workspace delete dev
    terraform workspace delete test
    rm -fR .terraform/

### Lessons learned

- Terraform can use AWS cli configuration in `~/.aws/` for authentication
- Avoid hard-coded security configuration in .tf files
- S3 backend: one state file per workspace in S3
- Currently selected workspace is stored in `.terraform/environment`
- Make sure the correct workspace is selected
- Parameters can be passed via `-var` or can be stored in `.tfvars` files and passed via `-var-file`
