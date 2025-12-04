# terraform-aws-vpc

## Overview

This terraform module creates an AWS VPC with a given CIDR block. It also creates multiple subnets(public and private), and for public subnets, it sets up an Internet Gateway and appropriate route tables.

## Features

- Creates a VPC with a specified CIDR block
- Creates public and private subnets
- Creates an Internet Gateway for public subnets
- Sets up route table for public subnets.

## Usage
'''
module "vpc" {
    source = "./module/vpc"

    vpc_config = {
        cidr_block = "10.0.0.0/16"
        name = "your-vpc"
    }

    subnet_config = {
      public_subnet = {
        cidr_block = "10.0.0.0/24"
        az = "us-east-2a"
        public = true
      }
      private_subnet = {
        cidr_block = "10.0.1.0/24"
        az = "us-east-2b"
        #subnet is private by default
      }
    }
}
'''
