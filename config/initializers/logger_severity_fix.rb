# Simple direct fix for Ruby 3.1 + Rails 6.0 logger compatibility issues
# This directly patches the problematic file by reopening the module

# Ensure the basic constants are defined globally
Object.const_set(:DEBUG, 0) unless Object.const_defined?(:DEBUG)
Object.const_set(:INFO, 1) unless Object.const_defined?(:INFO)
Object.const_set(:WARN, 2) unless Object.const_defined?(:WARN)
Object.const_set(:ERROR, 3) unless Object.const_defined?(:ERROR)
Object.const_set(:FATAL, 4) unless Object.const_defined?(:FATAL)
Object.const_set(:UNKNOWN, 5) unless Object.const_defined?(:UNKNOWN)

# Ensure Logger class is loaded
require 'logger'

# Define the constants in Logger if needed
::Logger.const_set(:DEBUG, 0) unless ::Logger.const_defined?(:DEBUG)
::Logger.const_set(:INFO, 1) unless ::Logger.const_defined?(:INFO)
::Logger.const_set(:WARN, 2) unless ::Logger.const_defined?(:WARN)
::Logger.const_set(:ERROR, 3) unless ::Logger.const_defined?(:ERROR)
::Logger.const_set(:FATAL, 4) unless ::Logger.const_defined?(:FATAL)
::Logger.const_set(:UNKNOWN, 5) unless ::Logger.const_defined?(:UNKNOWN)

# Ensure Severity is defined in Logger
unless ::Logger.const_defined?(:Severity)
  ::Logger.const_set(:Severity, Module.new)
  ::Logger::Severity.const_set(:DEBUG, 0)
  ::Logger::Severity.const_set(:INFO, 1)
  ::Logger::Severity.const_set(:WARN, 2)
  ::Logger::Severity.const_set(:ERROR, 3)
  ::Logger::Severity.const_set(:FATAL, 4)
  ::Logger::Severity.const_set(:UNKNOWN, 5)
  ::Logger.send(:include, ::Logger::Severity)
end

# This is the critical patch for ActiveSupport
# We're simply defining the module and its constants early
if defined?(ActiveSupport)
  # Only patch if the module exists
  if ActiveSupport.const_defined?(:LoggerThreadSafeLevel)
    # Ensure constants are defined
    unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:DEBUG)
      ActiveSupport::LoggerThreadSafeLevel.const_set(:DEBUG, 0)
      ActiveSupport::LoggerThreadSafeLevel.const_set(:INFO, 1)
      ActiveSupport::LoggerThreadSafeLevel.const_set(:WARN, 2)
      ActiveSupport::LoggerThreadSafeLevel.const_set(:ERROR, 3)
      ActiveSupport::LoggerThreadSafeLevel.const_set(:FATAL, 4)
      ActiveSupport::LoggerThreadSafeLevel.const_set(:UNKNOWN, 5)
    end
  end
end

# Create a callback to patch the module once Rails is initialized
ActiveSupport.on_load(:before_initialize) do
  if defined?(ActiveSupport::LoggerThreadSafeLevel)
    # Override the methods that are causing issues
    module ActiveSupport
      module LoggerThreadSafeLevel
        def local_level
          Thread.current["logger_#{object_id}_level"] || level
        end
        
        def local_level=(level)
          Thread.current["logger_#{object_id}_level"] = level
        end
      end
    end
  end
end if defined?(ActiveSupport) 