output "bastion_public_ip" {
    description = "The public IP of the EC2 instance"
    value = aws_instance.bastion.public_ip
}

output "application_private_ip" {
  description = "The private IP of the EC2 instance"
  value = aws_instance.application.private_ip
}

output "bastion_private_ip" {
  description = "The private IP of the EC2 instance"
  value = aws_instance.bastion.private_ip
}

output "application_instance_id" {
  description = "The Application's instance ID"
  value = aws_instance.application.id
}