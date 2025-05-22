require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.eager_load = true
  config.cache_classes = true
  config.silence_healthcheck_path = ENV.fetch("HEALTHCHECK_PATH", "/up")

  # Logging
  config.log_level = :info
  config.log_tags = [ :request_id ]
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [ :id ]

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Sidekiq / Redis
  config.active_job.queue_adapter = :sidekiq

  Sidekiq.configure_server do |config|
    config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
  end
end
