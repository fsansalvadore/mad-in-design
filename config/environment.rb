# Load the Rails application.
require_relative 'application'

# Double check that the Logger patch is working
unless defined?(Logger) && Logger.const_defined?(:Severity)
  puts "WARNING: Logger::Severity is not defined, forcing a reload..."
  require_relative 'initializers/logger_patch'
end

# Initialize the Rails application.
Rails.application.initialize!
