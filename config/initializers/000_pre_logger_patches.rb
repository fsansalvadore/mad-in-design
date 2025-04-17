#!/usr/bin/env ruby
# Special pre-initializer to ensure Logger compatibility with Ruby 3.1+ and Rails 6.0
# This file MUST load before any other initializers

# First, ensure the Logger class is properly defined
require 'logger'

# Ensure the Logger constants are defined at global level
DEBUG = Logger::DEBUG unless defined?(DEBUG)
INFO = Logger::INFO unless defined?(INFO)
WARN = Logger::WARN unless defined?(WARN)
ERROR = Logger::ERROR unless defined?(ERROR)
FATAL = Logger::FATAL unless defined?(FATAL)
UNKNOWN = Logger::UNKNOWN unless defined?(UNKNOWN)

# This is the critical fix: Ruby 3.1 changed how Logger::Severity is defined,
# but Rails 6.0 expects it to be available in a specific way.
unless defined?(::Logger::Severity)
  class ::Logger
    module Severity
      DEBUG = 0
      INFO = 1
      WARN = 2
      ERROR = 3
      FATAL = 4
      UNKNOWN = 5
    end
    
    include Severity
  end
end

# Define LOGGER constant to prevent issues
LOGGER = ::Logger unless defined?(LOGGER)

# DIRECT MONKEY PATCH for the specific file that's causing the error
# This is necessary because the built-in Rails code runs before our regular initializers
if defined?(ActiveSupport) && defined?(ActiveSupport::LoggerThreadSafeLevel)
  module ActiveSupport
    module LoggerThreadSafeLevel
      # Instead of removing constants, we'll directly define them
      # This is safer and avoids the error with remove_const

      # Define the constants directly without referencing Logger::Severity
      DEBUG = 0
      INFO = 1
      WARN = 2
      ERROR = 3
      FATAL = 4
      UNKNOWN = 5
      
      # Override the method that's causing issues
      def local_level
        Thread.current["logger_#{object_id}_level"] || level
      end
      
      def local_level=(level)
        Thread.current["logger_#{object_id}_level"] = level
      end
    end
  end
end 