Rails.application.config.session_store :redis_session_store,
  serializer: :json,
  redis: Settings['session_store'].to_hash.merge!(expire_after: 1.day),
  domain: Settings['app.domain']
