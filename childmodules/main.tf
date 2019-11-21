module "bucket_a" {
    source = "./mybucket"
    bucket_suffix = "chtz-testbucket-a"
    block_public_acls = false
}

module "bucket_b" {
    source = "./mybucket"
    bucket_suffix = "chtz-testbucket-b"
}

output "bucket_a" {
    value = module.bucket_a.bucket
}

output "bucket_b" {
    value = module.bucket_b.bucket
}
