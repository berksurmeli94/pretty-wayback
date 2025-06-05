resource "aws_instance" "postgres" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.postgres_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y postgresql postgresql-contrib

              sudo -u postgres psql -c "CREATE USER ${var.db_user} WITH PASSWORD '${var.db_pass}';"
              sudo -u postgres psql -c "CREATE DATABASE ${var.db_name} OWNER ${var.db_user};"

              echo "listen_addresses = '*'" >> /etc/postgresql/*/main/postgresql.conf
              echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/*/main/pg_hba.conf

              systemctl restart postgresql
              EOF

  tags = {
    Name = "postgres-service"
  }
}

resource "aws_security_group" "postgres_sg" {
  name        = "postgres-sg"
  description = "Allow PostgreSQL access"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # careful
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}