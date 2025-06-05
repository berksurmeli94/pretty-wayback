resource "aws_instance" "jobs_worker" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.jobs_worker_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y docker.io

              systemctl enable docker
              systemctl start docker

              docker run -d --name jobs-worker \\
                -e REDIS_URL=redis://${var.redis_private_ip}:6379 \\
                -e DATABASE_URL=postgres://${var.db_user}:${var.db_pass}@${var.db_private_ip}:5432/${var.db_name} \\
                ${var.worker_image}
              EOF

  tags = {
    Name = "jobs-worker-service"
  }
}

resource "aws_security_group" "jobs_worker_sg" {
  name        = "jobs-worker-sg"
  description = "Allow outbound connections"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
