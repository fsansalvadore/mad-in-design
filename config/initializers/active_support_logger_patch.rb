# Monkey patch for ActiveSupport::LoggerThreadSafeLevel to fix Rails 6.0 + Ruby 3.1 compatibility issues

# First, ensure Logger and its constants are defined
require 'logger'

# Define the missing constants in the global namespace to ensure they're available
Object.const_set(:DEBUG, Logger::DEBUG) unless Object.const_defined?(:DEBUG)
Object.const_set(:INFO, Logger::INFO) unless Object.const_defined?(:INFO)
Object.const_set(:WARN, Logger::WARN) unless Object.const_defined?(:WARN)
Object.const_set(:ERROR, Logger::ERROR) unless Object.const_defined?(:ERROR)
Object.const_set(:FATAL, Logger::FATAL) unless Object.const_defined?(:FATAL)
Object.const_set(:UNKNOWN, Logger::UNKNOWN) unless Object.const_defined?(:UNKNOWN)

# Ensure Logger class is defined
unless defined?(Logger)
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
    
    # Define the constants at class level if needed
    DEBUG = Severity::DEBUG
    INFO = Severity::INFO
    WARN = Severity::WARN
    ERROR = Severity::ERROR
    FATAL = Severity::FATAL
    UNKNOWN = Severity::UNKNOWN
  end
end

# Direct patch to ActiveSupport
module ActiveSupport
  module LoggerThreadSafeLevel
    # Override existing methods or define new implementations to avoid dependency on Logger::Severity
    
    # Override the add method to handle thread-safe level
    def add(severity, message = nil, progname = nil, &block)
      return true if severity.nil? || (defined?(@logdev) && @logdev.nil?)
      
      # Convert string severity to integer if needed
      if severity.is_a?(String)
        severity = case severity
        when 'DEBUG' then 0  # Logger::DEBUG
        when 'INFO' then 1   # Logger::INFO
        when 'WARN' then 2   # Logger::WARN
        when 'ERROR' then 3  # Logger::ERROR
        when 'FATAL' then 4  # Logger::FATAL
        when 'UNKNOWN' then 5 # Logger::UNKNOWN
        else 1  # Default to INFO
        end
      end
      
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
  end

  class Logger < ::Logger
    # Add the missing method that's causing the server to fail
    def self.logger_outputs_to?(logger, *sources)
      return false unless logger
      logdev = logger.instance_variable_get("@logdev")
      return false unless logdev
      logger_source = logdev.respond_to?(:dev) ? logdev.dev : nil
      sources.any? { |source| source == logger_source }
    end
    
    # Add the missing broadcast method
    def self.broadcast(logger)
      Module.new do
        define_method(:add) do |*args, &block|
          logger.add(*args, &block)
          super(*args, &block)
        end

        define_method(:<<) do |x|
          logger << x
          super(x)
        end

        define_method(:close) do
          logger.close
          super()
        end

        define_method(:progname=) do |name|
          logger.progname = name
          super(name)
        end

        define_method(:formatter=) do |formatter|
          logger.formatter = formatter
          super(formatter)
        end

        define_method(:level=) do |level|
          logger.level = level
          super(level)
        end
      end
    end
  end
end 