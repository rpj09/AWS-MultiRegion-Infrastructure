terraform {
  required_version = ">= 1.0"
}

provider "aws" {
  alias  = "us_east"
  region = "eu-north-1"
}

