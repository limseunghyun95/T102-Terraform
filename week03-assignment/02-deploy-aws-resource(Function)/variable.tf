variable "vpc_cidr" {
  type        = string
  description = "CIDR of Redshift VPC"
  default     = "10.10.0.0/16"
}

variable "redshift_port" {
  type        = number
  description = "Redshift port number"
  default     = 5439
}

variable "subnet1" {
  type        = string
  description = "Redshift VPC subnet"
  default     = "10.10.100.0/24"
}

variable "subnet2" {
  type        = string
  description = "Redshift VPC subnet"
  default     = "10.10.200.0/24"
}

variable "rs_cluster_identifier" {
  type        = string
  description = "Redshift Cluster name"
  default     = "seunghyun-cluster"
}

variable "rs_database_name" {
  type        = string
  description = "Redshift DB Cluster"
  default     = "seunghyun_database_cluster"
}

variable "rs_master_username" {
  type        = string
  description = "Redshift Master username"
  default     = "admin"
}

variable "rs_master_passwd" {
  type        = string
  description = "Redshift Master Password"
  sensitive   = true
  default     = "Admin1234"
}

variable "rs_nodetype" {
  type    = string
  default = "dc2.large"
}

variable "rs_cluster_type" {
  type    = string
  default = "single-node"
}