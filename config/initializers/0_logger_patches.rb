# Master initializer for all logger patches
# The '0_' prefix ensures this loads before other initializers

# Load the standard Ruby logger
require 'logger'

# Define constants at the global level
DEBUG = 0 unless defined?(DEBUG)
INFO = 1 unless defined?(INFO)
WARN = 2 unless defined?(WARN)
ERROR = 3 unless defined?(ERROR)
FATAL = 4 unless defined?(FATAL)
UNKNOWN = 5 unless defined?(UNKNOWN)

# Make sure Logger has the Severity module and constants
unless ::Logger.const_defined?(:Severity)
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
    
    unless const_defined?(:DEBUG)
      DEBUG = Severity::DEBUG
      INFO = Severity::INFO
      WARN = Severity::WARN
      ERROR = Severity::ERROR
      FATAL = Severity::FATAL
      UNKNOWN = Severity::UNKNOWN
    end
  end
end

# Define our patches regardless of whether Rails is loaded yet
module ActiveSupport
  # Thread-safe logger level for systems with multiple threads
  module LoggerThreadSafeLevel
    # Define constants directly without using Logger::Severity
    SEVERITY_MAP = {
      "DEBUG" => 0,
      "INFO" => 1,
      "WARN" => 2,
      "ERROR" => 3,
      "FATAL" => 4,
      "UNKNOWN" => 5
    }
    
    def local_level(level)
      case level
      when Integer
        level
      when Symbol, String
        str_level = level.to_s.upcase
        SEVERITY_MAP[str_level] || 1
      else
        1
      end
    end

    def level
      @level ||= 1 # Default to INFO level
    end

    def level=(level)
      @level = local_level(level)
    end

    def local_log_id
      Thread.current.__id__
    end
    
    def level_local(thread)
      thread[:logger_thread_safe_level] || level
    end

    def level_local=(level)
      Thread.current[:logger_thread_safe_level] = local_level(level)
    end

    def add(severity, message = nil, progname = nil, &block)
      return true if severity.nil? || (defined?(@logdev) && @logdev.nil?)
      
      severity = SEVERITY_MAP[severity.to_s.upcase] || severity if severity.is_a?(String) || severity.is_a?(Symbol)
      return true if severity < level_local(Thread.current)
      
      # Call the original add method (from Logger) if it exists
      if defined?(super)
        super
      else
        # Fallback implementation if super doesn't exist
        if message.nil?
          if block_given?
            message = yield
          else
            message = progname
            progname = nil
          end
        end
        
        # Basic logger implementation in case super doesn't work
        if defined?(@logdev) && @logdev.respond_to?(:write)
          severity_name = SEVERITY_MAP.key(severity) || "INFO"
          time = Time.now.strftime("%Y-%m-%d %H:%M:%S")
          formatted_message = "#{time} [#{severity_name}] #{message}\n"
          @logdev.write(formatted_message)
        else
          # Fallback to puts if log device isn't available
          puts "#{Time.now.strftime("%Y-%m-%d %H:%M:%S")} [INFO] #{message}"
        end
        
        true
      end
    end

    def debug(progname = nil, &block)
      add(0, nil, progname, &block)
    end

    def info(progname = nil, &block)
      add(1, nil, progname, &block)
    end

    def warn(progname = nil, &block)
      add(2, nil, progname, &block)
    end

    def error(progname = nil, &block)
      add(3, nil, progname, &block)
    end

    def fatal(progname = nil, &block)
      add(4, nil, progname, &block)
    end

    def unknown(progname = nil, &block)
      add(5, nil, progname, &block)
    end
  end
  
  # Implements silencing for any Logger instance
  module LoggerSilence
    # Silences the logger for the duration of the block.
    def silence(temporary_level = nil)
      temporary_level ||= 3 # ERROR level
      
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

# Apply the LoggerSilence module to the Logger class
::Logger.include(ActiveSupport::LoggerSilence) unless ::Logger.included_modules.include?(ActiveSupport::LoggerSilence)

# Define ActiveSupport::Logger class if ActiveSupport is defined
if defined?(ActiveSupport)
  module ActiveSupport
    # If the Logger class is already defined, remove it
    remove_const(:Logger) if const_defined?(:Logger)
    
    # Define our own version of ActiveSupport::Logger
    class Logger < ::Logger
      include LoggerSilence if defined?(LoggerSilence)
      include LoggerThreadSafeLevel if defined?(LoggerThreadSafeLevel)
      
      # Override any other methods that might be causing issues
      def initialize(*args)
        super

        # Set default log level based on environment (if Rails is defined)
        if defined?(Rails) && defined?(Rails.env)
          self.level = Rails.env.production? ? INFO : DEBUG
        else
          self.level = INFO # Default to INFO
        end
      end
      
      # Override formatter to include timestamps
      def formatter
        @formatter ||= begin
          proc do |severity, timestamp, progname, msg|
            formatted_severity = sprintf("%-5s", severity)
            formatted_time = timestamp.strftime("%Y-%m-%d %H:%M:%S.%L")
            "[#{formatted_time}] #{formatted_severity} #{msg}\n"
          end
        end
      end
    end
  end
end