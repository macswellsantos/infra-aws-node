# state.tf
terraform {
  backend "s3" {
    bucket       = "terraform-state-macswell"
    key          = "node/terraform.tfstate"
    region       = "us-east-2"
    encrypt      = true
    use_lockfile = true
  }
}