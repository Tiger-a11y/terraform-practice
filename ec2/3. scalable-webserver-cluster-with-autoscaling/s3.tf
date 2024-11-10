# Fetch current account identity
data "aws_caller_identity" "current" {}

# S3 Bucket to store ALB access logs
resource "aws_s3_bucket" "alb_logs" {
  bucket = "logs-bucket" # Ensure this bucket name is globally unique

  # region = "us-east-1"

  tags = {
    Name        = "logs-bucket"
    Environment = "Dev"
  }
}

# Bucket Policy for ALB to allow write access to the S3 Bucket
resource "aws_s3_bucket_policy" "alb_logs_policy" {
  bucket = aws_s3_bucket.alb_logs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "elasticloadbalancing.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "arn:aws:s3:::${aws_s3_bucket.alb_logs.bucket}/*"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = "${data.aws_caller_identity.current.account_id}"
          }
        }
      }
    ]
  })
}

# ALB for HTTP access with logging enabled
resource "aws_lb" "bucket_lb" {
  name               = "main-lb-bucket"
  internal           = false # Set to false for internet-facing load balancer
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nginx_sg.id]
  subnets            = [aws_subnet.subnet_public_a.id, aws_subnet.subnet_public_b.id] # Ensure the ALB spans multiple AZs

  # Enable access logs for the ALB
  access_logs {
    bucket  = aws_s3_bucket.alb_logs.bucket
    enabled = true
    prefix  = "alb-logs" # Prefix for log files inside the S3 bucket
  }

  enable_deletion_protection = true # Prevent accidental deletion
}
