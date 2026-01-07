# Project 1

This is a practice project created to learn Terraform and AWS infrastructure provisioning. It demonstrates the creation of a basic AWS architecture with VPC, EC2 instances, load balancer, and security groups.

## Project Overview

This project provisions a simple AWS infrastructure that includes:

- **VPC** with public and private subnets
- **EC2 Instances**: Application server (private subnet) and Bastion host (public subnet)
- **Application Load Balancer** for distributing traffic
- **Security Groups** with proper ingress/egress rules
- **IAM Roles** with SSM permissions for instance management
- **NAT Gateway** for private subnet internet access

## Architecture

```
Internet
    |
    v
Internet Gateway
    |
    v
Application Load Balancer (Public Subnet)
    |
    v
Application Instance (Private Subnet) <-- NAT Gateway
    ^
    |
Bastion Host (Public Subnet)
```

## Project Structure

```
.
├── main.tf                          # Root module configuration
├── modules/
│   ├── ec2/                        # EC2 instances module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── vpc/                        # VPC and networking module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security_group/             # Security groups module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── output.tf
│   ├── load_balancer/              # Application Load Balancer module
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── iam/                        # IAM roles and policies module
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
```

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.1.0
- AWS Account with appropriate credentials configured
- AWS CLI (optional, for credential management)

## Usage

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Review the execution plan**
   ```bash
   terraform plan
   ```

3. **Apply the configuration**
   ```bash
   terraform apply
   ```

4. **Destroy the infrastructure** (when done)
   ```bash
   terraform destroy
   ```

## Modules Description

### VPC Module
Creates the network infrastructure including:
- VPC with CIDR 192.168.0.0/16
- 2 public subnets (192.168.2.0/24, 192.168.3.0/24)
- 1 private subnet (192.168.1.0/24)
- Internet Gateway
- NAT Gateway with Elastic IP
- Route tables and associations

### EC2 Module
Provisions EC2 instances:
- **Application Instance**: Private subnet, no public IP
- **Bastion Host**: Public subnet with public IP for SSH access

### Security Group Module
Defines security rules:
- **ALB Security Group**: Allows HTTP (80) from internet
- **Application Security Group**: Allows HTTP from ALB, SSH from Bastion
- **Bastion Security Group**: Allows SSH from specific IP

### Load Balancer Module
Creates an Application Load Balancer in public subnets to distribute traffic to the application instance.

### IAM Module
Sets up IAM roles with:
- EC2 assume role policy
- SSM managed instance core policy for Systems Manager access
