data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_subnet" "primary" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "172.31.100.0/24"

  tags = {
    Name = "primary"
  }
}

resource "aws_subnet" "secondary" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = "172.31.101.0/24"

  tags = {
    Name = "secondary"
  }
}