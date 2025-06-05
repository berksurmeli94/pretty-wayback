variable "ami_id" {
  description = "AMI ID for PostgreSQL EC2"
}

variable "key_name" {
  description = "SSH key pair name"
}

variable "db_user" {
  description = "Database username"
}

variable "db_pass" {
  description = "Database password"
}

variable "db_name" {
  description = "Database name to create"
}