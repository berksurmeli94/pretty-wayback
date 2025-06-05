output "redis_public_ip" {
  value = module.redis.redis_ip
}

output "redis_private_ip" {
  value = module.redis.redis_private_ip
}

output "postgres_public_ip" {
  value = module.postgres.postgres_ip
}

output "postgres_private_ip" {
  value = module.postgres.postgres_private_ip
}

output "postgres_database_url" {
  value = module.postgres.database_url
}

output "elasticsearch_public_ip" {
  value = module.elasticsearch.elasticsearch_ip
}

output "elasticsearch_private_ip" {
  value = module.elasticsearch.elasticsearch_private_ip
}

output "jobs_worker_public_ip" {
  value = module.jobs_worker.jobs_worker_ip
}