variable "vpc_id" {
  type = string
  description = "Project's VPC ID"
}

# APPLICATION LOAD BALANCER SECURITY GROUP

resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "ALB Instance Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ALB SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_alb-sg" { #PERMITE HTTP DE QUALQUER LUGAR
  security_group_id = aws_security_group.alb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_alb-sg" { #PERMITE SAIDA DE TRAFEGO PARA QUALQUER LUGAR
  security_group_id = aws_security_group.alb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}

# APPLICATION EC2 INSTANCE SECURITY GROUP

resource "aws_security_group" "application-sg" {
  name        = "application-sg"
  description = "Bastions EC2 Instance Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Application SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_application-sg" { #PERMITE SSH PRO BASTION
  security_group_id = aws_security_group.application-sg.id
  referenced_security_group_id = aws_security_group.bastion-sg.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_icmp_application-sg" { #PERMITE PING PRO BASTION
  security_group_id = aws_security_group.application-sg.id
  referenced_security_group_id = aws_security_group.bastion-sg.id
  from_port         = -1
  ip_protocol       = "ICMP"
  to_port           = -1
}


resource "aws_vpc_security_group_ingress_rule" "allow_http_application-sg" { #PERMITE HTTP PRO ALB
  security_group_id = aws_security_group.application-sg.id
  referenced_security_group_id = aws_security_group.alb-sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_application-sg" { #PERMITE SAIDA DO TRAFEGO PARA TODOS OS LUGARES
  security_group_id = aws_security_group.application-sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol       = -1
}

# BASTION HOST SECURITY GROUP

resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Applications EC2 Instance Security Group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "Bastion SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_bastion-sg" { #PERMITE SSH PRA UM IP ESPECIFICO
  security_group_id = aws_security_group.bastion-sg.id
  cidr_ipv4         = "201.47.33.98/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_icmp_bastion-sg" { #PERMITE PING PRO BASTION
  security_group_id = aws_security_group.bastion-sg.id
  referenced_security_group_id = aws_security_group.application-sg.id
  from_port         = -1
  ip_protocol       = "ICMP"
  to_port           = -1
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_bastion-sg" { #PERMITE SAIDA DO TRAFEGO PARA TODOS OS LUGARES
  security_group_id = aws_security_group.bastion-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}


