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
      # Define SimpleFormatter that Rails expects
      class SimpleFormatter < ::Logger::Formatter
        # This method is invoked when a log event occurs
        def call(severity, timestamp, progname, msg)
          if msg.is_a?(String) && msg.encoding == Encoding::BINARY
            "[#{timestamp.strftime("%Y-%m-%d %H:%M:%S.%L")}] #{severity} -- : #{msg.inspect}\n"
          else
            "[#{timestamp.strftime("%Y-%m-%d %H:%M:%S.%L")}] #{severity} -- : #{msg}\n"
          end
        end
      end
      
      if defined?(LoggerSilence)
        include LoggerSilence
      end
      
      if defined?(LoggerThreadSafeLevel)
        include LoggerThreadSafeLevel
      end
      
      # Override any other methods that might be causing issues
      def initialize(*args)
        super

        # Set default formatter
        self.formatter = SimpleFormatter.new
        
        # Set default log level based on environment (if Rails is defined)
        if defined?(Rails) && defined?(Rails.env)
          self.level = Rails.env.production? ? 1 : 0  # INFO in production, DEBUG otherwise
        else
          self.level = 1  # Default to INFO level
        end
      end
    end
  end
end 