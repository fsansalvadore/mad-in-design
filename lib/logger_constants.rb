# Define logger constants that need to be available very early in the boot process
# This file is required directly from boot.rb

# Ensure Logger class is available
require 'logger'

# Define global-level constants
Object.const_set(:DEBUG, 0) unless Object.const_defined?(:DEBUG)
Object.const_set(:INFO, 1) unless Object.const_defined?(:INFO)
Object.const_set(:WARN, 2) unless Object.const_defined?(:WARN)
Object.const_set(:ERROR, 3) unless Object.const_defined?(:ERROR)
Object.const_set(:FATAL, 4) unless Object.const_defined?(:FATAL)
Object.const_set(:UNKNOWN, 5) unless Object.const_defined?(:UNKNOWN)

# Make sure the Logger::Severity module exists and has the correct constants
if defined?(::Logger)
  unless ::Logger.const_defined?(:Severity)
    # Define the Severity module and add constants
    ::Logger.const_set(:Severity, Module.new)
    ::Logger::Severity.const_set(:DEBUG, 0)
    ::Logger::Severity.const_set(:INFO, 1)
    ::Logger::Severity.const_set(:WARN, 2)
    ::Logger::Severity.const_set(:ERROR, 3)
    ::Logger::Severity.const_set(:FATAL, 4)
    ::Logger::Severity.const_set(:UNKNOWN, 5)
    
    # Include the Severity module in Logger
    ::Logger.send(:include, ::Logger::Severity)
  end
  
  # Define constants at Logger class level for compatibility
  unless ::Logger.const_defined?(:DEBUG)
    ::Logger.const_set(:DEBUG, 0)
    ::Logger.const_set(:INFO, 1)
    ::Logger.const_set(:WARN, 2)
    ::Logger.const_set(:ERROR, 3)
    ::Logger.const_set(:FATAL, 4)
    ::Logger.const_set(:UNKNOWN, 5)
  end
end

# Define a global LOGGER constant
Object.const_set(:LOGGER, ::Logger) unless Object.const_defined?(:LOGGER)

# Also require the Railtie to patch LoggerThreadSafeLevel
begin
  require_relative 'patches/logger_patch_railtie'
rescue => e
  # Ignore errors during early boot
  puts "Could not load logger_patch_railtie: #{e.message}"
end 