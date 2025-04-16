# Define Logger constants at the global level
# This ensures they're available even before Logger is fully loaded

# Define the constants if they don't exist
DEBUG = 0 unless defined?(DEBUG)
INFO = 1 unless defined?(INFO)
WARN = 2 unless defined?(WARN)
ERROR = 3 unless defined?(ERROR)
FATAL = 4 unless defined?(FATAL)
UNKNOWN = 5 unless defined?(UNKNOWN)

# Ensure Logger class is defined
unless defined?(Logger)
  class Logger
    module Severity
      DEBUG = 0
      INFO = 1
      WARN = 2
      ERROR = 3
      FATAL = 4
      UNKNOWN = 5
    end
    
    include Severity
    
    # Define the constants at class level if needed
    DEBUG = Severity::DEBUG
    INFO = Severity::INFO
    WARN = Severity::WARN
    ERROR = Severity::ERROR
    FATAL = Severity::FATAL
    UNKNOWN = Severity::UNKNOWN
  end
end 