# Early patches that need to be applied before Rails initializes
# This file gets required from config/boot.rb

# First, ensure Logger is properly defined
require 'logger'

# Define constants at the global level
Object.const_set(:DEBUG, 0) unless Object.const_defined?(:DEBUG)
Object.const_set(:INFO, 1) unless Object.const_defined?(:INFO)
Object.const_set(:WARN, 2) unless Object.const_defined?(:WARN)
Object.const_set(:ERROR, 3) unless Object.const_defined?(:ERROR)
Object.const_set(:FATAL, 4) unless Object.const_defined?(:FATAL)
Object.const_set(:UNKNOWN, 5) unless Object.const_defined?(:UNKNOWN)

# Ensure Logger::Severity module exists and has proper constants
if defined?(::Logger)
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
  
  # Make sure Logger class itself also has these constants
  ::Logger.const_set(:DEBUG, 0) unless ::Logger.const_defined?(:DEBUG)
  ::Logger.const_set(:INFO, 1) unless ::Logger.const_defined?(:INFO)
  ::Logger.const_set(:WARN, 2) unless ::Logger.const_defined?(:WARN)
  ::Logger.const_set(:ERROR, 3) unless ::Logger.const_defined?(:ERROR)
  ::Logger.const_set(:FATAL, 4) unless ::Logger.const_defined?(:FATAL)
  ::Logger.const_set(:UNKNOWN, 5) unless ::Logger.const_defined?(:UNKNOWN)
end

# Define a global LOGGER constant
Object.const_set(:LOGGER, ::Logger) unless Object.const_defined?(:LOGGER)

# Preparatory patch for ActiveSupport::LoggerThreadSafeLevel
module EarlyLoggerPatch
  def self.patch_logger_thread_safe_level
    if defined?(ActiveSupport) && defined?(ActiveSupport::LoggerThreadSafeLevel)
      if ActiveSupport::LoggerThreadSafeLevel.instance_methods.include?(:local_level_patched_for_ruby31)
        # Already patched
        return
      end
      
      # Define constants on the module
      unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:DEBUG)
        ActiveSupport::LoggerThreadSafeLevel.const_set(:DEBUG, 0) 
      end
      
      unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:INFO)
        ActiveSupport::LoggerThreadSafeLevel.const_set(:INFO, 1)
      end
      
      unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:WARN)
        ActiveSupport::LoggerThreadSafeLevel.const_set(:WARN, 2)
      end
      
      unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:ERROR)
        ActiveSupport::LoggerThreadSafeLevel.const_set(:ERROR, 3)
      end
      
      unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:FATAL)
        ActiveSupport::LoggerThreadSafeLevel.const_set(:FATAL, 4)
      end
      
      unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:UNKNOWN)
        ActiveSupport::LoggerThreadSafeLevel.const_set(:UNKNOWN, 5)
      end
      
      # Patch the local_level methods
      ActiveSupport::LoggerThreadSafeLevel.module_eval do
        def local_level
          Thread.current["logger_#{object_id}_level"] || level
        end
        
        def local_level=(level)
          Thread.current["logger_#{object_id}_level"] = level
        end
        
        def local_level_patched_for_ruby31
          true
        end
      end
      
      puts "Successfully patched ActiveSupport::LoggerThreadSafeLevel early in boot process"
    end
  end
end

# Try to patch now if ActiveSupport is already loaded
EarlyLoggerPatch.patch_logger_thread_safe_level

# Set up for pre-initialization using an initializer if possible
if defined?(Rails) && defined?(Rails::Application)
  Rails::Application.initializer(:patch_logger_thread_safe_level, 
                               before: :bootstrap_hook) do
    EarlyLoggerPatch.patch_logger_thread_safe_level
  end
end 