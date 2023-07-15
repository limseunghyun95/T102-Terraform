data "aws_ami" "seunghyun_amazonlinux2" {
  most_recent = true
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]

  tags = {
    Name = "seunghyun_amazonlinux2"
  }
}

resource "aws_instance" "seunghyun-ec2" {

  depends_on = [
    aws_internet_gateway.seunghyun-igw
  ]

  ami                         = data.aws_ami.seunghyun_amazonlinux2.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.seunghyun-sg.id}"]
  subnet_id                   = aws_subnet.seunghyun-subnet1.id

  user_data = <<-EOF
              #!/bin/bash
              wget https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64
              mv busybox-x86_64 busybox
              chmod +x busybox
              RZAZ=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone-id)
              IID=$(curl 169.254.169.254/latest/meta-data/instance-id)
              LIP=$(curl 169.254.169.254/latest/meta-data/local-ipv4)
              echo "<h1>RegionAz($RZAZ) : Instance ID($IID) : Private IP($LIP) : Web Server</h1>" : Seunghyun> index.html
              nohup ./busybox httpd -f -p 80 &
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "seunghyun-ec2"
  }
}

output "seunghyun_public_ip" {
  value       = aws_instance.seunghyun-ec2.public_ip
  description = "The public IP of the Instance"
}