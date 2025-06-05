variable "ami_ids" {
  description = "Map of AMI IDs for each service"
  type        = map(string)
}

variable "key_name" {
  description = "SSH key pair name"
}

variable "db_user" {}
variable "db_pass" {}
variable "db_name" {}

variable "worker_image" {}