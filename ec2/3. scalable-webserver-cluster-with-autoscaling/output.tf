output "nginx_server_public_ip" {
  description = "Nginx server public ip"
  value = aws_instance.nginx_server.public_ip
}