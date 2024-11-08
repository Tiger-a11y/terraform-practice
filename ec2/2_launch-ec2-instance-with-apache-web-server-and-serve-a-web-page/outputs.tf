output "ec2_public_key" {
  description = "Public Ip Of Ec2 Instance"
  value       = aws_instance.apache_server.public_ip
}
