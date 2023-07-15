data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "primary" {
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.0.100.0/24"

  tags = {
    Name = "primary"
  }
}

resource "aws_subnet" "secondary" {
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "10.0.101.0/24"

  tags = {
    Name = "secondary"
  }
}