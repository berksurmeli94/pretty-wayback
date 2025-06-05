variable "key_name" {
  description = "SSH key name to access the instance"
  type        = string
}

variable "ami_ids" {
  description = "Map of AMI IDs per service"
  type        = map(string)
}
