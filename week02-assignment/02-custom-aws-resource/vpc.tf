provider "aws" {
  region = "ap-northeast-2"
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "myvpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "seunghyun-vpc"
  }
}

resource "aws_subnet" "seunghyun-subnet1" {
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.10.100.0/24"

  tags = {
    Name = "seunghyun-subnet1"
  }
}

resource "aws_subnet" "seunghyun-subnet2" {
  vpc_id            = aws_vpc.myvpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.10.101.0/24"

  tags = {
    Name = "seunghyun-subnet2"
  }
}

resource "aws_internet_gateway" "seunghyun-igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "seunghyun-igw"
  }
}

resource "aws_route_table" "seunghyun-rt" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "seunghyun-rt"
  }
}

resource "aws_route_table_association" "seunghyun-rtassociation1" {
  subnet_id      = aws_subnet.seunghyun-subnet1.id
  route_table_id = aws_route_table.seunghyun-rt.id
}

resource "aws_route_table_association" "seunghyun-rtassociation2" {
  subnet_id      = aws_subnet.seunghyun-subnet2.id
  route_table_id = aws_route_table.seunghyun-rt.id
}

resource "aws_route" "seunghyun-default-route" {
  route_table_id         = aws_route_table.seunghyun-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.seunghyun-igw.id
}

output "aws_vpc_id" {
  value = aws_vpc.myvpc.id
}
