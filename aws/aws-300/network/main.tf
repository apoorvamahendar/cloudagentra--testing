# ─────────────────────────────────────────────
# VPC
# ─────────────────────────────────────────────
resource "aws_vpc" "web_server_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name  = "web-server-vpc"
    Stack = "network"
  }
}

# ─────────────────────────────────────────────
# Public Subnet
# ─────────────────────────────────────────────
resource "aws_subnet" "web_server_public_subnet" {
  vpc_id                  = aws_vpc.web_server_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name  = "web-server-public-subnet"
    Stack = "network"
  }
}

# ─────────────────────────────────────────────
# Internet Gateway
# ─────────────────────────────────────────────
resource "aws_internet_gateway" "web_server_igw" {
  vpc_id = aws_vpc.web_server_vpc.id

  tags = {
    Name  = "web-server-igw"
    Stack = "network"
  }
}

# ─────────────────────────────────────────────
# Route Table (public)
# ─────────────────────────────────────────────
resource "aws_route_table" "web_server_public_rtb" {
  vpc_id = aws_vpc.web_server_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web_server_igw.id
  }

  tags = {
    Name  = "web-server-public-rtb"
    Stack = "network"
  }
}

# ─────────────────────────────────────────────
# Route Table Association
# ─────────────────────────────────────────────
resource "aws_route_table_association" "web_server_public_rtb_assoc" {
  subnet_id      = aws_subnet.web_server_public_subnet.id
  route_table_id = aws_route_table.web_server_public_rtb.id
}

# ─────────────────────────────────────────────
# Security Group (shell - rules managed below)
# ─────────────────────────────────────────────
resource "aws_security_group" "web_server_sg" {
  name        = "web-server-sg"
  description = "Allow HTTP and SSH inbound; all outbound"
  vpc_id      = aws_vpc.web_server_vpc.id

  tags = {
    Name  = "web-server-sg"
    Stack = "network"
  }
}

# Ingress - HTTP (port 80)
resource "aws_vpc_security_group_ingress_rule" "web_server_sg_http" {
  security_group_id = aws_security_group.web_server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "Allow HTTP from anywhere"

  tags = {
    Name  = "web-server-sg-http"
    Stack = "network"
  }
}

# Ingress - SSH (port 22)
resource "aws_vpc_security_group_ingress_rule" "web_server_sg_ssh" {
  security_group_id = aws_security_group.web_server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "Allow SSH from anywhere"

  tags = {
    Name  = "web-server-sg-ssh"
    Stack = "network"
  }
}

# Egress - all traffic
resource "aws_vpc_security_group_egress_rule" "web_server_sg_all_out" {
  security_group_id = aws_security_group.web_server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"

  tags = {
    Name  = "web-server-sg-egress-all"
    Stack = "network"
  }
}

# ─────────────────────────────────────────────
# Outputs - consumed by the compute stack
# ─────────────────────────────────────────────
output "vpc_id" {
  description = "ID of the web-server VPC"
  value       = aws_vpc.web_server_vpc.id
}

output "public_subnet_id" {
  description = "ID of the web-server public subnet"
  value       = aws_subnet.web_server_public_subnet.id
}

output "internet_gateway_id" {
  description = "ID of the web-server Internet Gateway"
  value       = aws_internet_gateway.web_server_igw.id
}

output "route_table_id" {
  description = "ID of the web-server public route table"
  value       = aws_route_table.web_server_public_rtb.id
}

output "route_table_association_id" {
  description = "ID of the route table / subnet association"
  value       = aws_route_table_association.web_server_public_rtb_assoc.id
}

output "security_group_id" {
  description = "ID of the web-server security group (used by the compute stack)"
  value       = aws_security_group.web_server_sg.id
}