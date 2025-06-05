module "jobs_worker" {
  source   = "../../modules/services/jobs-worker"
  ami_id   = var.ami_ids["jobs_worker"]
  key_name = var.key_name
}

module "redis" {
  source   = "../../modules/services/redis"
  ami_id   = var.ami_ids["redis"]
  key_name = var.key_name
}

module "postgres" {
  source   = "../../modules/services/postgres"
  ami_id   = var.ami_ids["postgres"]
  key_name = var.key_name
}

module "elasticsearch" {
  source   = "../../modules/services/elasticsearch"
  ami_id   = var.ami_ids["elasticsearch"]
  key_name = var.key_name
}
