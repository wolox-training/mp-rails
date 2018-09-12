# config/initializers/sidekiq.rb

Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.credentials[Rails.env.to_sym][:sidekiq][:url], namespace: "wbooks_#{Rails.env}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.credentials[Rails.env.to_sym][:sidekiq][:url], namespace: "wbooks_#{Rails.env}" }
end
