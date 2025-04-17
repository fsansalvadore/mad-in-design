# Very simple and direct fixes for Ruby 3.1 Logger compatibility
# This file is loaded early in boot.rb

# First, ensure the logger library is loaded
require 'logger'

# Define global constants
DEBUG = 0 unless defined?(DEBUG)
INFO = 1 unless defined?(INFO)
WARN = 2 unless defined?(WARN)
ERROR = 3 unless defined?(ERROR)
FATAL = 4 unless defined?(FATAL)
UNKNOWN = 5 unless defined?(UNKNOWN)

# Make sure the Logger class has constants
::Logger.const_set(:DEBUG, 0) unless ::Logger.const_defined?(:DEBUG)
::Logger.const_set(:INFO, 1) unless ::Logger.const_defined?(:INFO)
::Logger.const_set(:WARN, 2) unless ::Logger.const_defined?(:WARN)
::Logger.const_set(:ERROR, 3) unless ::Logger.const_defined?(:ERROR)
::Logger.const_set(:FATAL, 4) unless ::Logger.const_defined?(:FATAL)
::Logger.const_set(:UNKNOWN, 5) unless ::Logger.const_defined?(:UNKNOWN)

# Ensure Logger::Severity exists
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

# Define the LOGGER constant
LOGGER = ::Logger unless defined?(LOGGER)

# Define a method to be called once ActiveSupport is loaded
def patch_logger_thread_safe_level
  if defined?(ActiveSupport) && defined?(ActiveSupport::LoggerThreadSafeLevel)
    # Only patch if not already patched
    return if ActiveSupport::LoggerThreadSafeLevel.method_defined?(:patched_for_ruby31)
    
    # Define constants directly on the module
    ActiveSupport::LoggerThreadSafeLevel.const_set(:DEBUG, 0) unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:DEBUG)
    ActiveSupport::LoggerThreadSafeLevel.const_set(:INFO, 1) unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:INFO)
    ActiveSupport::LoggerThreadSafeLevel.const_set(:WARN, 2) unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:WARN)
    ActiveSupport::LoggerThreadSafeLevel.const_set(:ERROR, 3) unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:ERROR)
    ActiveSupport::LoggerThreadSafeLevel.const_set(:FATAL, 4) unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:FATAL)
    ActiveSupport::LoggerThreadSafeLevel.const_set(:UNKNOWN, 5) unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:UNKNOWN)
    
    # Patch methods on the module
    ActiveSupport::LoggerThreadSafeLevel.module_eval do
      def local_level
        Thread.current["logger_#{object_id}_level"] || level
      end
      
      def local_level=(level)
        Thread.current["logger_#{object_id}_level"] = level
      end
      
      def patched_for_ruby31
        true
      end
    end
    
    puts "Successfully patched ActiveSupport::LoggerThreadSafeLevel for Ruby 3.1 compatibility"
  end
end

# Try to patch now if ActiveSupport is already loaded
patch_logger_thread_safe_level if defined?(ActiveSupport) 