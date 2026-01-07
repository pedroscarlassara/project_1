variable "instance_type" {
    description = "Type of the EC2 instance"
    default = "t2.micro"
}

variable "ami_id" {
    description = "AMI ID of the EC2 instance"
    default = "ami-068c0051b15cdb816"
}

variable "project_public_subnet_1_id" {
  type = string
  description = "Project's VPC public subnet ID"
}

variable "project_private_subnet_1_id" {
  type = string
  description = "Project's VPC private subnet ID"
}

variable "bastion_sg_id" {
  type = string
  description = "Bastion's security group ID"
}

variable "application_sg_id" {
  type = string
  description = "Application's security group ID"
}

variable "ec2role_name" {
  type = string
  description = "The name of the EC2 Role"
}
