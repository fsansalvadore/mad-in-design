# Emergency patch for SimpleFormatter
# This handles the specific error about missing ActiveSupport::Logger::SimpleFormatter

# First ensure Logger is loaded
require 'logger'

# Very direct approach to ensure SimpleFormatter exists
module ActiveSupport
  if defined?(ActiveSupport::Logger) && !ActiveSupport::Logger.const_defined?(:SimpleFormatter)
    class Logger
      # Define SimpleFormatter for Rails compatibility
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
      
      # Force setting the formatter on existing loggers
      if defined?(Rails) && defined?(Rails.logger) && Rails.logger.is_a?(ActiveSupport::Logger)
        Rails.logger.formatter = SimpleFormatter.new
      end
    end
  end
end

# Define it globally as fallback
unless defined?(SimpleFormatter)
  class SimpleFormatter < ::Logger::Formatter
    def call(severity, timestamp, progname, msg)
      "[#{timestamp.strftime("%Y-%m-%d %H:%M:%S.%L")}] #{severity} -- : #{msg}\n"
    end
  end
end 