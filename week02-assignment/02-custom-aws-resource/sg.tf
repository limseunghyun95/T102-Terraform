resource "aws_security_group" "seunghyun-sg" {
  vpc_id      = aws_vpc.myvpc.id
  name        = "seunghyun SG"
  description = "my security group"

  tags = {
    Name = "seunghyun-sg"
  }
}

resource "aws_security_group_rule" "seunghyun-sg-inbound" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.seunghyun-sg.id
}

resource "aws_security_group_rule" "seunghyun-sg-outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.seunghyun-sg.id
}
