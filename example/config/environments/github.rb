Rails.application.configure do
  config.eager_load = true
  config.log_level = :debug
  config.log_tags = [:request_id]
  config.cache_store = :memory_store
  config.active_job.queue_adapter = :test
  config.log_formatter = ::Logger::Formatter.new
  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end
  config.active_record.dump_schema_after_migration = false
end
