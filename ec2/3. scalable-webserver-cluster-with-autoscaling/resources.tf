# Main VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

# Public Subnet in Availability Zone 1
resource "aws_subnet" "subnet_public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-a"
  }
}

# Public Subnet in Availability Zone 2
resource "aws_subnet" "subnet_public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-b"
  }
}

# Private Subnet in Availability Zone 2
resource "aws_subnet" "subnet_private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet"
  }
}

# Internet Gateway for the VPC
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-internet-gateway"
  }
}

# Route Table for public subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate Route Table with Public Subnet A
resource "aws_route_table_association" "public_association_a" {
  subnet_id      = aws_subnet.subnet_public_a.id
  route_table_id = aws_route_table.public.id
}

# Associate Route Table with Public Subnet B
resource "aws_route_table_association" "public_association_b" {
  subnet_id      = aws_subnet.subnet_public_b.id
  route_table_id = aws_route_table.public.id
}

# Fetch current public IP address dynamically
data "http" "my_ip" {
  url = "https://api.ipify.org?format=text"
}

# Security Group for NGINX Server Instances
resource "aws_security_group" "nginx_sg" {
  name        = "nginx_sg"
  description = "Allow HTTP, HTTPS, and SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Uncomment this section to allow SSH access from a specific IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.http.my_ip.body}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "nginx-security-group"
  }
}

# IAM Role for EC2 Instances
resource "aws_iam_role" "ec2_role" {
  name = "ec2_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })

  tags = {
    Name = "ec2-role"
  }
}

# Instance Profile for the IAM Role
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

# IAM Role Policy for EC2 with Dynamic S3 Bucket Name
resource "aws_iam_role_policy" "ec2_role_policy" {
  name = "ec2_role_policy"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "s3:PutObject"
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${aws_s3_bucket.alb_logs.bucket}/*"
      },
      {
        Effect   = "Allow",
        Action   = "ec2-instance-connect:SendSSHPublicKey",
        Resource = "*"
      }
    ]
  })
}

# Load Balancer (ALB) with two public subnets
resource "aws_lb" "main" {
  name               = "main-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nginx_sg.id]
  subnets            = [aws_subnet.subnet_public_a.id, aws_subnet.subnet_public_b.id]

  tags = {
    Name = "main-alb"
  }
}

# ALB Listener
resource "aws_lb_listener" "nginx_lb_listener" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_target_group.arn
  }

  tags = {
    Name = "nginx-lb-listener"
  }
}

# Target Group for NGINX Instances
resource "aws_lb_target_group" "nginx_target_group" {
  name     = "ngnix-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    protocol = "HTTP"
    path     = "/"
  }

  tags = {
    Name = "nginx-target-group"
  }
}

# Launch Template for EC2 Instances
resource "aws_launch_template" "nginx_server" {
  name_prefix   = "nginx_server"
  image_id      = var.ami_id
  instance_type = "t2.micro"

  network_interfaces {
    security_groups             = [aws_security_group.nginx_sg.id] # Specify security group ID
    associate_public_ip_address = true                             # Associate a public IP for public subnet instances
  }

  user_data = base64encode(file("scripts/user_data.sh"))

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  tags = {
    Name = "nginx-server-instance"
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "nginx_asg" {
  name = "nginx-auto-scaling-group"

  # depends_on          = [aws_security_group.nginx_sg]
  desired_capacity    = 2
  min_size            = 2
  max_size            = 2
  vpc_zone_identifier = [aws_subnet.subnet_public_a.id, aws_subnet.subnet_private.id]

  launch_template {
    name    = aws_launch_template.nginx_server.name
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true

  target_group_arns = [aws_lb_target_group.nginx_target_group.arn]
}

# Auto Scaling Policies
resource "aws_autoscaling_policy" "scale_up" {
  name                   = "scale_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.nginx_asg.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "scale_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.nginx_asg.name
}
