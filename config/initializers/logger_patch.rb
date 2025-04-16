# Fix Logger compatibility issues with Ruby 3.1+
require 'logger'

# Ensure Logger::Severity is defined
unless Logger.const_defined?(:Severity)
  class Logger
    module Severity
      DEBUG = 0
      INFO = 1
      WARN = 2
      ERROR = 3
      FATAL = 4
      UNKNOWN = 5
    end
    
    include Severity
    
    # Adding these constants if they don't exist
    unless const_defined?(:DEBUG)
      DEBUG = Severity::DEBUG
      INFO = Severity::INFO
      WARN = Severity::WARN
      ERROR = Severity::ERROR
      FATAL = Severity::FATAL
      UNKNOWN = Severity::UNKNOWN
    end
  end
end

# Fix ActiveSupport::LoggerThreadSafeLevel
if defined?(ActiveSupport) && ActiveSupport.const_defined?(:LoggerThreadSafeLevel)
  module ActiveSupport
    module LoggerThreadSafeLevel
      # Override the add method to handle thread-safe level
      def add(severity, message = nil, progname = nil, &block)
        return true if severity.nil? || (defined?(@logdev) && @logdev.nil?)
        
        severity = severity_level(severity) if severity.is_a?(String)
        return true if severity < level_local(Thread.current)
        
        # Call the original add method (from Logger)
        super
      end
      
      # Define thread-safe level getter
      def level_local(thread)
        thread[:logger_thread_safe_level] || level
      end
      
      # Define thread-safe level setter
      def level_local=(level)
        Thread.current[:logger_thread_safe_level] = level
      end
      
      # Ensure the severity_level method exists
      unless method_defined?(:severity_level)
        def severity_level(severity)
          case severity
          when 'DEBUG' then Logger::DEBUG
          when 'INFO' then Logger::INFO
          when 'WARN' then Logger::WARN
          when 'ERROR' then Logger::ERROR
          when 'FATAL' then Logger::FATAL
          when 'UNKNOWN' then Logger::UNKNOWN
          else Logger::INFO
          end
        end
      end
    end
  end
end 