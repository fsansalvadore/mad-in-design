# Patch for Ruby 3.1 compatibility with Rails 6.0
# This addresses the missing Logger::Severity constant issue

require 'logger'

unless defined?(::Logger::Severity)
  ::Logger.const_set(:Severity, ::Logger::Severity)
end

module ActiveSupport
  module LoggerThreadSafeLevel
    def after_initialize
      @local_levels = Concurrent::Map.new(initial_capacity: Concurrent.processor_count)
    end unless method_defined?(:after_initialize)
  end
end 