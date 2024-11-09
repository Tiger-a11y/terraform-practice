resource "aws_s3_bucket" "alb_logs" {
  bucket = "logs_bucket"
}

resource "aws_lb" "bucket_lb" {
  name               = "main-lb-bucket"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nginx_sg.id]
  subnets            = [aws_subnet.subnet_public.id]

  access_logs {
    bucket  = aws_s3_bucket.alb_logs.bucket
    enabled = true
  }
}
