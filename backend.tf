terraform {
  backend "s3" {
    bucket = "rpj-terraform-state"
    key    = "AWS-MultiRegion-Infrastructure/dev/terraform.tfstate"
    region = "eu-north-1"
  }
}
