# Complete replacement for ActiveSupport::LoggerThreadSafeLevel
# This overrides the problematic module in activesupport/lib/active_support/logger_thread_safe_level.rb

# First ensure Logger is loaded
require 'logger'

# Define these constants to ensure they're available
DEBUG = 0 unless defined?(DEBUG)
INFO = 1 unless defined?(INFO)
WARN = 2 unless defined?(WARN)
ERROR = 3 unless defined?(ERROR)
FATAL = 4 unless defined?(FATAL)
UNKNOWN = 5 unless defined?(UNKNOWN)

# Remove the module if it's already defined to avoid warnings
ActiveSupport.send(:remove_const, :LoggerThreadSafeLevel) if defined?(ActiveSupport::LoggerThreadSafeLevel)

module ActiveSupport
  # Thread-safe logger level for systems with multiple threads.
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
      
      # Call the original add method (from Logger)
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
        puts "#{Time.now.strftime("%Y-%m-%d %H:%M:%S")} [#{'INFO'}] #{message}"
      end
      
      true
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
end 