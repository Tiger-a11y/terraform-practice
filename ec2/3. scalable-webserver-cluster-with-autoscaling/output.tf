output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "instance_ids" {
  value = aws_autoscaling_group.nginx_asg.instance_ids
}

output "s3_bucket_name" {
  value = aws_s3_bucket.alb_logs.bucket
}
