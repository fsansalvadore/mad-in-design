# Configuration for Heroku environment
if ENV['HEROKU_APP_NAME'] || ENV['DYNO'] 
  # Note: Cloudinary configuration moved to config/initializers/cloudinary.rb
  
  # Use HTTP caching to improve performance
  if defined?(ActiveSupport::Cache)
    Rails.application.config.action_controller.perform_caching = true
    Rails.application.config.cache_store = :memory_store, { size: 64.megabytes }
    Rails.application.config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  end
  
  # Set default URL options for ActionMailer
  if defined?(ActionMailer::Base)
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.default_url_options = { 
      host: ENV['HEROKU_APP_NAME'] ? "#{ENV['HEROKU_APP_NAME']}.herokuapp.com" : ENV['APP_HOST']
    }
  end
end 