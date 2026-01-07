output "bastion_sg_id" {
  description = "Bastion's security group ID"
  value = aws_security_group.bastion-sg.id
}

output "application_sg_id" {
  description = "Application's security group ID"
  value = aws_security_group.application-sg.id
}

output "alb_sg_id"  {
  description = "ALB security group ID"
  value = aws_security_group.alb-sg.id
}