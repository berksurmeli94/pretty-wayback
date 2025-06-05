output "jobs_worker_ip" {
  value = aws_instance.jobs_worker.public_ip
}