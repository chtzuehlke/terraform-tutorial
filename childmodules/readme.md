# Terraform tutorial

## Child modules

### Child module: provisioning script

see mybucket/variables.tf
see mybucket/main.tf
see mybucket/outputs.tf

### Root module: provisioning script

see main.tf

### Terraform apply

Commands:

    terraform init
    terraform workspace new dev
    terraform apply -auto-approve

Output:

    ...
    bucket_a = dev-chtz-testbucket-a
    bucket_b = dev-chtz-testbucket-b

### Breaking thins and fixing state (Ia)

Commands:

    aws s3api delete-bucket --bucket dev-chtz-testbucket-a
    
    terraform apply

Output:

    # module.bucket_a.aws_s3_bucket.samplebucket will be created

### Breaking thins and fixing state (Ib)

Please continue with II (fortunately, behaviour "Ib" is fixed in the most recent terraform- or AWS-provider version)

Commands 

    aws s3api delete-bucket --bucket dev-chtz-testbucket-b

    terraform apply

Output

    ...
    Error: error reading S3 bucket Public Access Block: NoSuchBucket: The specified bucket does not exist
    ...

Commands:

    terraform state rm module.bucket_b.aws_s3_bucket_public_access_block.samplebucket_nonpublic[0]

    terraform apply

Output:

    ...
    # module.bucket_b.aws_s3_bucket.samplebucket will be created
    # module.bucket_b.aws_s3_bucket_public_access_block.samplebucket_nonpublic[0] will be created
    ...

### Breaking things and fixing state (II)

Commands:

    terraform destroy

    aws s3api create-bucket --bucket dev-chtz-testbucket-b --create-bucket-configuration LocationConstraint=eu-central-1

    terraform apply

Output:

    Error: Error creating S3 bucket: BucketAlreadyOwnedByYou: Your previous request to create the named bucket succeeded and you already own it.

Command:

    terraform import module.bucket_b.aws_s3_bucket.samplebucket dev-chtz-testbucket-b

    terraform apply

### Lessons learned

- Use child modules to "divide and conquer" and for re-use
- You can use `count` to make resources conditionally optional. Use this feature sparingly (increased complexity)
- Don't manually mess with terraform-managed resources
