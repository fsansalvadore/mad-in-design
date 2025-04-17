# Direct override for ActiveSupport::Logger
# This ensures compatibility with Ruby 3.1+

# First ensure Logger is loaded
require 'logger'

# Wait for Rails to be initialized
Rails.application.config.after_initialize do
  if defined?(ActiveSupport) && defined?(::Logger)
    module ActiveSupport
      # If the Logger class is already defined, remove it
      remove_const(:Logger) if const_defined?(:Logger)
      
      # Define our own version of ActiveSupport::Logger
      class Logger < ::Logger
        include LoggerSilence if defined?(LoggerSilence)
        include LoggerThreadSafeLevel if defined?(LoggerThreadSafeLevel)
        
        # Override any other methods that might be causing issues
        def initialize(*args)
          super

          # Set default log level to INFO in production
          self.level = Rails.env.production? ? INFO : DEBUG
        end
        
        # Override formatter to include timestamps
        def formatter
          @formatter ||= begin
            proc do |severity, timestamp, progname, msg|
              formatted_severity = sprintf("%-5s", severity)
              formatted_time = timestamp.strftime("%Y-%m-%d %H:%M:%S.%L")
              "[#{formatted_time}] #{formatted_severity} #{msg}\n"
            end
          end
        end
      end
    end
    
    puts "Successfully patched ActiveSupport::Logger for Ruby 3.1+ compatibility"
  end
end 