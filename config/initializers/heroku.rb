# Configuration for Heroku environment
if ENV['HEROKU_APP_NAME'] || ENV['DYNO'] 
  # Configure Cloudinary for production
  if defined?(Cloudinary)
    Cloudinary.config do |config|
      config.cloud_name = ENV['CLOUDINARY_CLOUD_NAME'] || 'demo'
      config.api_key = ENV['CLOUDINARY_API_KEY'] || '111111111111111'
      config.api_secret = ENV['CLOUDINARY_API_SECRET'] || 'xxxxxxxxxxxxxxxxxxxxxxx'
      config.secure = true
      config.cdn_subdomain = true
    end
  end
  
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