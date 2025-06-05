variable "aws_region" {
  default = "eu-central-1"
}

variable "ami_id" {
  description = "Ubuntu AMI ID"
  type        = string
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name from AWS"
  type        = string
}

variable "private_key_path" {
  description = "Path to your .pem file"
  type        = string
}