variable "alb_sg_id" {
  type = string
  description = "ALB security group ID"
}

variable "vpc_id" {
  type = string
  description = "VPCs ID"
}

variable "project_public_subnet_1_id" {
  type = string
  description = "Public Subnet 1 ID"
}

variable "project_public_subnet_2_id" {
  type = string
  description = "Public Subnet 2 ID"
}

variable "application_instance_id" {
  type = string
  description = "The Application's instance ID"
}