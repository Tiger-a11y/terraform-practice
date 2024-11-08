terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  profile = "Devops1"
}


resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http_ssh"
  description = "Allow HTTP and SSH inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "apache_server_key" {
  key_name = "apache-server-key" 
  public_key = file("./apache-server-key.pub")
}

# EC2 Instance
resource "aws_instance" "apache_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.apache_server_key.key_name
  security_groups        = [aws_security_group.allow_http_ssh.name]

  # Run Apache installation script at instance launch
  user_data = file("scripts/install_apache.sh")

  tags = {
    Name = "Apache-Web-Server"
  }
}
