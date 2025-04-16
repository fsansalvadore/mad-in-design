# Custom application configuration
module MadInDesign
  class CustomConfig
    class << self
      def setup
        # Set any custom configuration variables here
        Rails.application.config.custom_setting = 'custom_value'
        
        # Example: Configure time formats
        # Only set up time formats if Rails has the DATE_FORMATS constant defined
        if defined?(Time::DATE_FORMATS)
          Time::DATE_FORMATS[:custom_date] = '%d %b %Y'
        end
        
        # Example: Set application-wide settings
        Rails.application.config.app_name = 'MAD in Design'
        
        # Log that custom configuration has been loaded
        if Rails.respond_to?(:logger) && Rails.logger
          Rails.logger.info 'Custom configuration loaded successfully'
        else
          puts 'Custom configuration loaded successfully'
        end
      end
    end
  end
end

# Initialize the custom configuration
MadInDesign::CustomConfig.setup 