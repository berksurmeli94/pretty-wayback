provider "aws" {
  region = var.aws_region
}

locals {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
}

resource "aws_instance" "redis_server" {
  ami           = local.ami
  instance_type = local.instance_type
  key_name      = local.key_name

  tags = {
    Name = "redis"
  }

  provisioner "file" {
    source      = "redis-setup.sh"
    destination = "/home/ubuntu/redis-setup.sh"

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x redis-setup.sh",
      "bash redis-setup.sh"
    ]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }
}

resource "aws_instance" "elastic_server" {
  ami           = local.ami
  instance_type = local.instance_type
  key_name      = local.key_name

  tags = {
    Name = "elasticsearch"
  }

  provisioner "file" {
    source      = "elastic-setup.sh"
    destination = "/home/ubuntu/elastic-setup.sh"

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x elastic-setup.sh",
      "bash elastic-setup.sh"
    ]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }
}

resource "aws_instance" "workers" {
  ami           = local.ami
  instance_type = local.instance_type
  key_name      = local.key_name

  tags = {
    Name = "workers"
  }

    provisioner "file" {
    source      = "../worker-app"                # copy the entire Rails app
    destination = "/home/ubuntu/worker-app"

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "file" {
    source      = "worker-setup.sh"
    destination = "/home/ubuntu/worker-setup.sh"

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x worker-setup.sh",
      "bash worker-setup.sh"
    ]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  provisioner "file" {
    content     = data.template_file.secrets.rendered
    destination = "/home/ubuntu/worker-app/.env"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }
}

data "template_file" "secrets" {
  template = file("${path.module}/secrets.tpl")

  vars = {
    redis_ip  = aws_instance.redis_server.private_ip
    elastic_ip = aws_instance.elastic_server.private_ip
  }
}

