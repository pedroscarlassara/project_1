resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = var.ec2role_name
}

resource "aws_instance" "application" {
    ami = var.ami_id
    instance_type = var.instance_type
    user_data = file("./modules/ec2/userdata.sh")
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
    subnet_id = var.project_private_subnet_1_id
    vpc_security_group_ids = [var.application_sg_id]
    associate_public_ip_address = false

    tags = {
        Name = "Application Instance"
    }
}

resource "aws_instance" "bastion" {
  ami = var.ami_id
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  subnet_id = var.project_public_subnet_1_id
  vpc_security_group_ids = [ var.bastion_sg_id ]
  associate_public_ip_address = true

  tags = {
    Name = "Bastion Instance"
  }
}