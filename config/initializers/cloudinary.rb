require 'cloudinary'

# Configure Cloudinary
# Priority: Use CLOUDINARY_URL env var if present, otherwise use separate variables
if ENV['CLOUDINARY_URL'].present?
  # No extra configuration needed - Cloudinary automatically configures from this URL
  Cloudinary.config_from_url(ENV['CLOUDINARY_URL'])
  
  # Extract cloud name from URL for logging
  begin
    cloud_name = ENV['CLOUDINARY_URL'].match(/cloudinary:\/\/.*@([^\/]+)/)[1]
    Rails.logger.info "Cloudinary configured using CLOUDINARY_URL with cloud name: #{cloud_name}"
  rescue
    Rails.logger.info "Cloudinary configured using CLOUDINARY_URL"
  end
else
  # Fall back to separate config variables if CLOUDINARY_URL is not present
  Cloudinary.config do |config|
    config.cloud_name = ENV['CLOUDINARY_CLOUD_NAME']
    config.api_key = ENV['CLOUDINARY_API_KEY']
    config.api_secret = ENV['CLOUDINARY_API_SECRET']
    config.secure = true
    config.cdn_subdomain = true
    config.enhance_image_tag = true
    config.static_file_support = true
  end
  
  # Validate configuration
  if Cloudinary.config.cloud_name.present?
    Rails.logger.info "Cloudinary configured with cloud name: #{Cloudinary.config.cloud_name}"
  else
    Rails.logger.error "ERROR: Cloudinary cloud_name is not configured! Images will not work correctly."
    Rails.logger.error "Please set the CLOUDINARY_URL or CLOUDINARY_CLOUD_NAME environment variable."
    
    # Set a fallback cloud name for development
    if Rails.env.development?
      Cloudinary.config.cloud_name = 'associazione-mind-mad-in-design'
      Rails.logger.warn "Using fallback cloud_name 'associazione-mind-mad-in-design' for Cloudinary in development mode."
    end
  end
end

# Monkey patch to handle missing configurations gracefully
module CloudinaryHelpers
  def cl_image_path(public_id, options = {})
    return nil unless public_id.present?
    return nil unless Cloudinary.config.cloud_name.present?
    
    begin
      Cloudinary::Utils.cloudinary_url(public_id, options)
    rescue => e
      Rails.logger.error "Error generating Cloudinary URL: #{e.message}"
      nil
    end
  end
end

# Include helpers in ActionView
if defined?(ActionView::Base)
  ActionView::Base.include CloudinaryHelpers
end 