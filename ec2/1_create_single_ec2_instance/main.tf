terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75.0"
    }
  }
}

provider "aws" {
  profile = "Devops1"  # Ensure this profile is set correctly
  region  = "us-east-1"
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "MyFirstEC2Instance"
  }
}
