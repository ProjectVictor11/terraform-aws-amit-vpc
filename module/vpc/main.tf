resource "aws_vpc" "name" {
    cidr_block = var.vpc_config.cidr_block
    tags = {
      Name = var.vpc_config.name
    }
  
}

resource "aws_subnet" "name" {
  vpc_id = aws_vpc.name.id
  for_each = var.subnet_config #key=value sub1={cidr=..., az=...}
  cidr_block = each.value.cidr_block
  availability_zone = each.value.az
  tags = {
    Name = each.key
  }
}

locals {
  public_subnet = {
    for key, config in var.subnet_config: key => config if config.public
    # sub1={cidr_block=..., az= ...., public = true}, sub2={...}
  }
  private_subnet = {
    for key, config in var.subnet_config: key => config if !config.public
    # sub1={cidr_block=..., az= ...., public = true}, sub2={...}
  }
}

#if there is atleast one public subnet
resource "aws_internet_gateway" "name" {
    count = length(local.public_subnet) > 0 ? 1 : 0
    vpc_id = aws_vpc.name.id
}

resource "aws_route_table" "name" {
  count = length(local.public_subnet) > 0 ? 1 : 0
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name[0].id
  }
}

resource "aws_route_table_association" "name" {
    for_each = local.public_subnet
    route_table_id = aws_route_table.name[0].id
    subnet_id = aws_subnet.name[each.key].id
}

