provider "aws" {
  region = var.AWS_REGION
}


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  assign_generated_ipv6_cidr_block = false

  instance_tenancy = "default"

}

resource "aws_subnet" "prod-subnet-public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"
}

resource "aws_internet_gateway" "prod-igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "prod-public-crt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-igw.id
  }
}

resource "aws_route_table_association" "prod-crta-public" {
  subnet_id      = aws_subnet.prod-subnet-public-1.id
  route_table_id = aws_route_table.prod-public-crt.id
}

