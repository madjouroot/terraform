provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "bems-backend"
    key    = "prod.tfstate"
    region = "us-east-1"
    shared_credentials_file = "~/.aws/credentials"    
  }
}

module "prod" {
    source = "../modules/ec2module/"
    aws_common_tag = {
      Name = "ec2-prd-bems2"
    }

    instance_type = "t2.micro"
    bems_SG = "bemsAcces1-prod"
  
}