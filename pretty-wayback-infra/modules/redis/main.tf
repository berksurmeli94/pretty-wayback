resource "aws_instance" "redis" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.redis_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y redis
              systemctl enable redis-server
              systemctl start redis-server
              EOF

  tags = {
    Name = "redis-service"
  }
}

resource "aws_security_group" "redis_sg" {
  name        = "redis-sg"
  description = "Allow Redis"

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #careful
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}