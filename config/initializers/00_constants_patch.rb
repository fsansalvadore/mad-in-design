# Super-early initializer to define constants before ActiveSupport loads
# This initializer will run before any others because of the '00_' prefix

# These constants must be defined at the top level
Object.const_set(:DEBUG, 0) unless Object.const_defined?(:DEBUG)
Object.const_set(:INFO, 1) unless Object.const_defined?(:INFO)
Object.const_set(:WARN, 2) unless Object.const_defined?(:WARN)
Object.const_set(:ERROR, 3) unless Object.const_defined?(:ERROR)
Object.const_set(:FATAL, 4) unless Object.const_defined?(:FATAL)
Object.const_set(:UNKNOWN, 5) unless Object.const_defined?(:UNKNOWN)

# Ensure the Logger class is loaded
require 'logger'

# Ensure Logger::Severity exists
unless ::Logger.const_defined?(:Severity)
  ::Logger.const_set(:Severity, Module.new)
  
  # Define the constants in the Severity module
  ::Logger::Severity.const_set(:DEBUG, 0)
  ::Logger::Severity.const_set(:INFO, 1)
  ::Logger::Severity.const_set(:WARN, 2)
  ::Logger::Severity.const_set(:ERROR, 3)
  ::Logger::Severity.const_set(:FATAL, 4)
  ::Logger::Severity.const_set(:UNKNOWN, 5)
  
  # Include the Severity module in Logger
  ::Logger.send(:include, ::Logger::Severity)
end

# Define constants directly on Logger
::Logger.const_set(:DEBUG, 0) unless ::Logger.const_defined?(:DEBUG)
::Logger.const_set(:INFO, 1) unless ::Logger.const_defined?(:INFO)
::Logger.const_set(:WARN, 2) unless ::Logger.const_defined?(:WARN)
::Logger.const_set(:ERROR, 3) unless ::Logger.const_defined?(:ERROR)
::Logger.const_set(:FATAL, 4) unless ::Logger.const_defined?(:FATAL)
::Logger.const_set(:UNKNOWN, 5) unless ::Logger.const_defined?(:UNKNOWN)

# Define a global LOGGER constant
Object.const_set(:LOGGER, ::Logger) unless Object.const_defined?(:LOGGER)

# Create a patch for ActiveSupport::LoggerThreadSafeLevel
if defined?(ActiveSupport) && defined?(ActiveSupport::LoggerThreadSafeLevel)
  module ActiveSupport
    module LoggerThreadSafeLevel
      # Define constants directly in the module
      DEBUG = 0 unless const_defined?(:DEBUG)
      INFO = 1 unless const_defined?(:INFO)
      WARN = 2 unless const_defined?(:WARN)
      ERROR = 3 unless const_defined?(:ERROR)
      FATAL = 4 unless const_defined?(:FATAL)
      UNKNOWN = 5 unless const_defined?(:UNKNOWN)
      
      # Override the methods that cause issues
      def local_level
        Thread.current["logger_#{object_id}_level"] || level
      end
      
      def local_level=(level)
        Thread.current["logger_#{object_id}_level"] = level
      end
    end
  end
end 