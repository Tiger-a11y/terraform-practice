resource "aws_instance" "nginx_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = "your-key-pair"

  user_data = file("scripts/user_data.sh")

  vpc_security_group_ids = [ aws_security_group.nginx_sg.id ]

  metadata_options {
    http_tokens = "required"
    http_endpoint = "enabled"
    http_put_response_hop_limit = 1
  }

  tags = {
    Name = "nginx-web-server"
  }
}
