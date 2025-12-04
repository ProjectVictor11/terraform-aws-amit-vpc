Sample configuration to work with this module

USAGE
'''
provider "aws" {
  region = "us-east-2"
}

module "vpc" {
    source = "./module/vpc"

    vpc_config = {
        cidr_block = "10.0.0.0/16"
        name = "my-vpc"
    }

    subnet_config = {
      public_subnet1 = {
        cidr_block = "10.0.0.0/18"
        az = "us-east-2a"
        public = true
      }
      public_subnet2 = {
        cidr_block = "10.0.64.0/18"
        az = "us-east-2c"
        public = true
      }
      private_subnet = {
        cidr_block = "10.0.128.0/18"
        az = "us-east-2b"
      }
    }
  
}

'''