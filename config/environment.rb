# Load the Rails application.
require_relative 'application'

# Final verification to ensure Logger patches are in place
# This is a safeguard for the Heroku environment
if defined?(ActiveSupport)
  # Apply our direct patch
  if defined?(patch_logger_thread_safe_level)
    patch_logger_thread_safe_level
  end
  
  # Force-patch ActiveSupport::LoggerThreadSafeLevel if it's still using Logger::Severity
  if ActiveSupport.const_defined?(:LoggerThreadSafeLevel)
    module ActiveSupport
      module LoggerThreadSafeLevel
        # Define constants directly to fix Ruby 3.1 compatibility
        DEBUG = 0 unless const_defined?(:DEBUG)
        INFO = 1 unless const_defined?(:INFO)
        WARN = 2 unless const_defined?(:WARN)
        ERROR = 3 unless const_defined?(:ERROR)
        FATAL = 4 unless const_defined?(:FATAL)
        UNKNOWN = 5 unless const_defined?(:UNKNOWN)
        
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
        
        # Ensure the local_level method is correctly defined
        unless method_defined?(:local_level_patched_for_ruby31)
          def local_level
            Thread.current["logger_#{object_id}_level"] || level
          end
          
          def local_level=(level)
            Thread.current["logger_#{object_id}_level"] = level
          end
          
          def local_level_patched_for_ruby31
            true
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
