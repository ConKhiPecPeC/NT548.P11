# VPC
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "VPC"
  }
}

# Add this block to enable VPC Flow Logging
resource "aws_flow_log" "vpc_flow_log" {
  log_destination      = "arn:aws:logs:${us-east-1}:${data.aws_caller_identity.current.account_id}:log-group:VPCFlowLogs"
  log_destination_type = "cloud-watch-logs"
  traffic_type         = "ALL"  # Options: ACCEPT, REJECT, ALL
  vpc_id               = aws_vpc.vpc.id
}


# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr_public_subnet

  tags = {
    Name = "Public_subnet"
  }
}

#Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr_private_subnet

  tags = {
    Name = "Private_subnet"
  }
}
#Internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Internet_gateway"
  }
}


#Default security group
resource "aws_default_security_group" "default_security_group" {
  vpc_id = aws_vpc.vpc.id

  
  ingress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = []
  }

  
  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = []
  }

  tags = {
    Name = "Default_security_group"
  }
}

#Route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public_RT"
  }
}

resource "aws_route_table_association" "public_subnet_rt-association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}