# Load the Rails application.
require_relative 'application'

# Final verification to ensure Logger patches are in place
# This is a safeguard for the Heroku environment
if defined?(ActiveSupport)
  # Force-patch ActiveSupport::LoggerThreadSafeLevel if it's still using Logger::Severity
  if ActiveSupport.const_defined?(:LoggerThreadSafeLevel)
    module ActiveSupport
      module LoggerThreadSafeLevel
        # Define direct access to Logger constants without going through Severity
        unless method_defined?(:severity_level)
          def severity_level(severity)
            case severity
            when 'DEBUG' then 0
            when 'INFO' then 1
            when 'WARN' then 2
            when 'ERROR' then 3
            when 'FATAL' then 4
            when 'UNKNOWN' then 5
            else 1
            end
          end
        end
      end
    end
  end
  
  # Force reload the patches if needed
  require_relative 'initializers/logger_patch'
  require_relative 'initializers/active_support_logger_patch'
end

# Initialize the Rails application.
Rails.application.initialize!
