variable "ami_id" {}
variable "key_name" {}

variable "redis_private_ip" {
  description = "Private IP of the Redis instance"
}

variable "db_private_ip" {
  description = "Private IP of the PostgreSQL instance"
}

variable "db_user" {}
variable "db_pass" {}
variable "db_name" {}

variable "worker_image" {
  description = "Docker image for the worker (e.g. dockerhubuser/app-worker:latest)"
}