# frozen_string_literal: true

# This is a patched version of ActiveSupport::LoggerThreadSafeLevel 
# Made specifically for compatibility with Ruby 3.1+
#
# Original file is at activesupport/lib/active_support/logger_thread_safe_level.rb

require "logger"

module ActiveSupport
  module LoggerThreadSafeLevel
    # Define constants directly instead of using Logger::Severity
    # PATCHED FOR RUBY 3.1
    DEBUG = 0
    INFO = 1
    WARN = 2
    ERROR = 3
    FATAL = 4
    UNKNOWN = 5

    def local_level
      Thread.current["logger_#{object_id}_level"] || level
    end

    def local_level=(level)
      Thread.current["logger_#{object_id}_level"] = level
    end

    def after_initialize
      @level = INFO
    end

    def add(severity, message = nil, progname = nil, &block)
      return true if severity.nil? || severity < local_level
      super
    end
  end
end