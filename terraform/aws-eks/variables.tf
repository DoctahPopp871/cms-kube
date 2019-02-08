variable "aws_key_path" {}
variable "aws_key_name" {}

variable "vpc_cidr" {
    description = "CIDR for the HumanDB Prod VPC ... "
    default = "10.11.0.0/16"
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "us-east-1"
}

variable "aws_role_arn" {
    description = "Role ARN for the Build"
    default = "arn:aws:iam::413230511243:role/DeployAdmin"
}

variable "mgmt_cidr" {
    description = "CIDR for ApoppMgmt IPs"
    default = "199.20.44.0/22"
}

variable "eks-cluster-name" {
    description = "EKS Cluster Name "
    default = "humandb-01"
    type = "string"
}

variable "hdb_subnet_cidr_a" {
    description = "CIDR for subnet_a hdb ... "
    default = "10.11.1.0/24"
}

variable "hdb_subnet_cidr_b" {
    description = "CIDR for subnet_b hdb ... "
    default = "10.11.2.0/24"
}

variable "hdb_subnet_cidr_c" {
    description = "CIDR for subnet_c hdb ... "
    default = "10.11.3.0/24"
}

variable "hdb_subnet_cidr_d" {
    description = "CIDR for subnet_d hdb ... "
    default = "10.11.4.0/24"
}

variable "hdb_subnet_cidr_e" {
    description = "CIDR for subnet_e hdb ... "
    default = "10.11.5.0/24"
}

variable "hdb_subnet_cidr_f" {
    description = "CIDR for subnet_f hdb ... "
    default = "10.11.6.0/24"
}
