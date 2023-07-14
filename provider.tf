terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.0.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1.0"
    }
  }


}

# Configure the AWS Provider
provider "aws" {
  profile = "odooCredential"
  region  = "ap-southeast-2"
}

provider "tls" {}

provider "null" {
  # Configuration options for the null provider, if any
}