module "redis" {
  source   = "./modules/redis"           # redis modülünün yolu
  ami_id   = var.ami_ids["redis"]        # redis için ami_id'yi dışarıdan al
  key_name = var.key_name                # SSH key
}

module "postgres" {
  source   = "./modules/postgres"
  ami_id   = var.ami_ids["postgres"]
  key_name = var.key_name

  db_user = var.db_user
  db_pass = var.db_pass
  db_name = var.db_name
}

module "jobs_worker" {
  source           = "./modules/services/jobs-worker"
  ami_id           = var.ami_ids["jobs_worker"]
  key_name         = var.key_name

  redis_private_ip = module.redis.redis_private_ip
  db_private_ip    = module.postgres.postgres_private_ip

  db_user = var.db_user
  db_pass = var.db_pass
  db_name = var.db_name

  worker_image = var.worker_image
}

module "elasticsearch" {
  source   = "./modules/elasticsearch"
  ami_id   = var.ami_ids["elasticsearch"]
  key_name = var.key_name
}
