# Define the IAM role
resource "aws_iam_role" "ec2_role" {
  name = "EC2Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach a policy to the IAM role (e.g., read-only access to S3)
resource "aws_iam_role_policy_attachment" "ec2_role_policy_attachment" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess" # Example policy
}

#EC2
resource "aws_instance" "public_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  security_groups = [module.security_group.public_security_group_id]
  key_name = "TF_key"

  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name  # Add this line

  associate_public_ip_address = false

  metadata_options {
    http_tokens = "required"  # Enforces the use of IMDSv2
    http_put_response_hop_limit = 1  # Optional: limits the hop count for HTTP PUT responses
  }

  ebs_optimized = true

  monitoring = true

  ebs_block_device {
    device_name = "/dev/xvda"  
    volume_size = 20            
    encrypted   = true         
  }

  tags = {
    Name = "Public_instance"
  }
}
# Define an IAM instance profile to associate the IAM role with the EC2 instance
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "EC2InstanceProfile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_role" "private_instance_role" {
  name = "PrivateInstanceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach a policy to the new IAM role (e.g., AmazonS3ReadOnlyAccess)
resource "aws_iam_role_policy_attachment" "private_instance_role_policy_attachment" {
  role       = aws_iam_role.private_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess" # Adjust this as needed
}

resource "aws_iam_instance_profile" "private_instance_profile" {
  name = "PrivateInstanceProfile"
  role = aws_iam_role.private_instance_role.name
}

resource "aws_instance" "private_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  security_groups = [module.security_group.private_security_group_id]
  key_name = "TF_key"

  iam_instance_profile   = aws_iam_instance_profile.private_instance_profile.name  # Attach the new IAM role

   metadata_options {
    http_tokens = "required"  
  }

  ebs_optimized = true

  monitoring = true

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = 20  
    encrypted   = true  
  }

  tags = {
    Name = "Private_instance"
  }
}
