output "redis_ip" {
  value = aws_instance.redis.public_ip
}

output "redis_private_ip" {
  value = aws_instance.redis.private_ip
}