# Direct override for ActiveSupport::Logger
# This ensures compatibility with Ruby 3.1+

# First ensure Logger is loaded
require 'logger'

# Don't use Rails.application here, it might not be defined yet
if defined?(ActiveSupport) && defined?(::Logger)
  module ActiveSupport
    # If the Logger class is already defined, remove it
    remove_const(:Logger) if const_defined?(:Logger)
    
    # Define our own version of ActiveSupport::Logger
    class Logger < ::Logger
      if defined?(LoggerSilence)
        include LoggerSilence
      end
      
      if defined?(LoggerThreadSafeLevel)
        include LoggerThreadSafeLevel
      end
      
      # Override any other methods that might be causing issues
      def initialize(*args)
        super

        # Set default log level based on environment (if Rails is defined)
        if defined?(Rails) && defined?(Rails.env)
          self.level = Rails.env.production? ? 1 : 0  # INFO in production, DEBUG otherwise
        else
          self.level = 1  # Default to INFO level
        end
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
end 