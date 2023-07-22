resource "aws_vpc" "redshift_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = lower("Redshift_vpc")
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_internet_gateway" "redshift_igw" {
  vpc_id = aws_vpc.redshift_vpc.id

  depends_on = [
    aws_vpc.redshift_vpc
  ]

  tags = {
    Name = lower("redshift_igw")
  }
}

resource "aws_default_security_group" "redshift_sg" {
  vpc_id = aws_vpc.redshift_vpc.id

  ingress {
    from_port  = var.redshift_port
    to_port    = var.redshift_port
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = lower("redshift_sg")
  }

  depends_on = [
    aws_vpc.redshift_vpc
  ]
}

resource "aws_subnet" "redshift_subnet1" {
  vpc_id            = aws_vpc.redshift_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = var.subnet1

  tags = {
    Name = lower("Redshift_subnet1")
  }
}

resource "aws_subnet" "redshift_subnet2" {
  vpc_id            = aws_vpc.redshift_vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block        = var.subnet2

  tags = {
    Name = lower("Redshift_subnet2")
  }
}