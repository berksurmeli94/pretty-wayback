output "elasticsearch_ip" {
  value = aws_instance.elasticsearch.public_ip
}

output "elasticsearch_private_ip" {
  value = aws_instance.elasticsearch.private_ip
}
