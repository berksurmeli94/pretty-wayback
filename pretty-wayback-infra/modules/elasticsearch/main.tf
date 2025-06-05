resource "aws_instance" "elasticsearch" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.elasticsearch_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y docker.io
              systemctl enable docker
              systemctl start docker

              docker run -d --name elasticsearch \\
                -e discovery.type=single-node \\
                -p 9200:9200 \\
                docker.elastic.co/elasticsearch/elasticsearch:7.10.1
              EOF

  tags = {
    Name = "elasticsearch-service"
  }
}

resource "aws_security_group" "elasticsearch_sg" {
  name        = "elasticsearch-sg"
  description = "Allow Elasticsearch"

  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # İleride sadece app IP'leriyle kısıtla
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
