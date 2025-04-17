# This is an early initializer that patches ActiveSupport's logger_thread_safe_level.rb directly
# The 000_ prefix ensures it runs before any other initializers

# Check if we're already patched
return if defined?(ACTIVESUPPORT_LOGGER_PATCH_APPLIED) && ACTIVESUPPORT_LOGGER_PATCH_APPLIED

# First, find the gem
def find_activesupport_gem
  if defined?(Bundler)
    begin
      gem_spec = Bundler.rubygems.find_name('activesupport').first
      gem_path = gem_spec.full_gem_path if gem_spec
      
      if gem_path && File.directory?(gem_path)
        target_file = File.join(gem_path, 'lib', 'active_support', 'logger_thread_safe_level.rb')
        return target_file if File.exist?(target_file)
      end
    rescue => e
      puts "Error finding activesupport gem: #{e.message}"
    end
  end
  nil
end

# Find and replace the problematic file
target_file = find_activesupport_gem
if target_file
  begin
    # Create a complete replacement for the file
    new_content = <<~RUBY
      # frozen_string_literal: true
      # Ruby 3.1 compatible version
      
      require "logger"
      
      module ActiveSupport
        module LoggerThreadSafeLevel
          # Define constants directly to avoid depending on Logger::Severity
          DEBUG = 0
          INFO = 1
          WARN = 2
          ERROR = 3
          FATAL = 4
          UNKNOWN = 5
      
          def local_level
            Thread.current["logger_\#{object_id}_level"] || level
          end
      
          def local_level=(level)
            Thread.current["logger_\#{object_id}_level"] = level
          end
      
          def add(severity, message = nil, progname = nil, &block)
            return true if (severity.nil? || severity < local_level)
            super
          end
        end
      end
    RUBY
    
    # Create backup if needed
    backup_file = "#{target_file}.original"
    File.write(backup_file, File.read(target_file)) unless File.exist?(backup_file)
    
    # Write the new content
    File.write(target_file, new_content)
    
    puts "Successfully patched ActiveSupport logger_thread_safe_level.rb for Ruby 3.1 compatibility"
    ACTIVESUPPORT_LOGGER_PATCH_APPLIED = true
  rescue => e
    puts "Error patching logger_thread_safe_level.rb: #{e.message}"
  end
end

# Define constants at the global level
Object.const_set(:DEBUG, 0) unless Object.const_defined?(:DEBUG)
Object.const_set(:INFO, 1) unless Object.const_defined?(:INFO)
Object.const_set(:WARN, 2) unless Object.const_defined?(:WARN)
Object.const_set(:ERROR, 3) unless Object.const_defined?(:ERROR)
Object.const_set(:FATAL, 4) unless Object.const_defined?(:FATAL)
Object.const_set(:UNKNOWN, 5) unless Object.const_defined?(:UNKNOWN)

# Make sure Logger class has constants
require 'logger'
::Logger.const_set(:DEBUG, 0) unless ::Logger.const_defined?(:DEBUG)
::Logger.const_set(:INFO, 1) unless ::Logger.const_defined?(:INFO)
::Logger.const_set(:WARN, 2) unless ::Logger.const_defined?(:WARN)
::Logger.const_set(:ERROR, 3) unless ::Logger.const_defined?(:ERROR)
::Logger.const_set(:FATAL, 4) unless ::Logger.const_defined?(:FATAL)
::Logger.const_set(:UNKNOWN, 5) unless ::Logger.const_defined?(:UNKNOWN)

# Ensure Severity exists
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