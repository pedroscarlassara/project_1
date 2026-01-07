output "vpc_id" {
  value = aws_vpc.project-vpc.id
}

output "public_subnet_1" {
  value = aws_subnet.project-public-subnet-1.id
}

output "public_subnet_2" {
  value = aws_subnet.project-public-subnet-2.id
}

output "private_subnet_1" {
  value = aws_subnet.project-private-subnet-1.id
}

output "cidr_block" {
  value = aws_vpc.project-vpc.cidr_block
}