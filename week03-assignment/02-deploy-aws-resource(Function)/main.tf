resource "aws_redshift_subnet_group" "redshift_subnet_group" {
  name = "redshift-subnet-group"
  subnet_ids = [
    aws_subnet.redshift_subnet1.id,
    aws_subnet.redshift_subnet2.id,
  ]

  tags = {
    Name = lower("Redshift_subnet_group")
  }
}

resource "aws_redshift_cluster" "redshift_cluster" {
  cluster_identifier        = var.rs_cluster_identifier
  database_name             = var.rs_database_name
  master_username           = var.rs_master_username
  master_password           = var.rs_master_passwd
  cluster_type              = var.rs_cluster_type
  node_type                 = var.rs_nodetype
  cluster_subnet_group_name = aws_redshift_subnet_group.redshift_subnet_group.id
  skip_final_snapshot       = true

  depends_on = [
    aws_vpc.redshift_vpc,
    aws_default_security_group.redshift_sg,
    aws_redshift_subnet_group.redshift_subnet_group,
  ]
}
