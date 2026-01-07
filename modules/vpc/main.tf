resource "aws_vpc" "project-vpc" {
  cidr_block = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Project VPC"
  }
}

resource "aws_subnet" "project-public-subnet-1" {
  vpc_id = aws_vpc.project-vpc.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "Project Public Subnet 1"
  }
}

resource "aws_subnet" "project-public-subnet-2" {
  vpc_id = aws_vpc.project-vpc.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Project Public Subnet 2"
  }
}

resource "aws_subnet" "project-private-subnet-1" {
  vpc_id = aws_vpc.project-vpc.id
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "Project Private Subnet 1"
  }
}

resource "aws_eip" "project-natgw-eip" {
  domain = "vpc"
  depends_on = [aws_internet_gateway.project-igw]
}

resource "aws_internet_gateway" "project-igw" {
  vpc_id = aws_vpc.project-vpc.id

  tags = {
    Name =  "Project IGW"
  }
}

resource "aws_nat_gateway" "project-natgw" {
  vpc_id = aws_vpc.project-vpc.id
  connectivity_type = "public"
  availability_mode = "regional"

  depends_on = [aws_internet_gateway.project-igw]

  tags = {
    Name = "Project NAT GW"
  }
}

resource "aws_route_table" "project-private-rt" {
  vpc_id = aws_vpc.project-vpc.id

  route {
    cidr_block = "192.168.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.project-natgw.id
  }

  tags = {
    Name = "Project Private RT"
  }

}

resource "aws_route_table" "project-public-rt" {
  vpc_id = aws_vpc.project-vpc.id

  route {
    cidr_block = "192.168.0.0/16"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project-igw.id
  }

  tags = {
    Name = "Project Public RT"
  }
}

resource "aws_route_table_association" "public-association-1" {
  route_table_id = aws_route_table.project-public-rt.id
  subnet_id = aws_subnet.project-public-subnet-1.id
}

resource "aws_route_table_association" "public-association-2" {
  route_table_id = aws_route_table.project-public-rt.id
  subnet_id = aws_subnet.project-public-subnet-2.id
}

resource "aws_route_table_association" "private-association" {
  route_table_id = aws_route_table.project-private-rt.id
  subnet_id = aws_subnet.project-private-subnet-1.id
}



