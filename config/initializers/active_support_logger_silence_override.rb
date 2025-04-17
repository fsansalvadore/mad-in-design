# Complete replacement for ActiveSupport::LoggerSilence
# This overrides the problematic module in activesupport/lib/active_support/logger_silence.rb

# First ensure Logger is loaded
require 'logger'

# Skip the require_relative which could cause circular dependencies
# require_relative 'active_support_logger_override'

# Only remove the module if it's already defined to avoid warnings
if defined?(ActiveSupport) && defined?(ActiveSupport::LoggerSilence)
  ActiveSupport.send(:remove_const, :LoggerSilence)
end

module ActiveSupport
  # Implements silencing for any Logger instance
  module LoggerSilence
    # Silences the logger for the duration of the block.
    def silence(temporary_level = nil)
      if temporary_level.nil? && (defined?(::Logger::Severity::ERROR) rescue false)
        temporary_level = ::Logger::Severity::ERROR
      else
        # Default to ERROR level if Logger::Severity isn't available
        temporary_level = 3
      end
      
      if defined?(ActiveSupport::LoggerThreadSafeLevel) && 
         self.class.include?(ActiveSupport::LoggerThreadSafeLevel)
        # Handle silencing for thread-safe loggers
        old_local_level = level_local(Thread.current)
        begin
          self.level_local = temporary_level
          yield self
        ensure
          self.level_local = old_local_level
        end
      else
        # Handle silencing for regular loggers
        old_level = level
        begin
          self.level = temporary_level
          yield self
        ensure
          self.level = old_level
        end
      end
    end
  end
end

# Apply LoggerSilence to the Logger class if it's not already included
if !::Logger.included_modules.include?(ActiveSupport::LoggerSilence)
  ::Logger.include(ActiveSupport::LoggerSilence)
end 