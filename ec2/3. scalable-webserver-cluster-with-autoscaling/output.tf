output "alb_dns_name" {
  description = "alb_dns_name"
  value = aws_lb.main.dns_name
}

output "instance_ids" {
  description = "instance_ids"
  value = aws_autoscaling_group.nginx_asg.id
}

output "s3_bucket_name" {
  description = "s3_bucket_name"
  value = aws_s3_bucket.alb_logs.bucket
}

output "ec2_role" {
  description = "ec2_role"
  value = aws_iam_role.ec2_role.name
}