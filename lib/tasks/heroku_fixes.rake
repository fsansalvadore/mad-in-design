namespace :heroku do
  desc "Apply fixes for Ruby 3.1 compatibility on Heroku"
  task fix_logger: :environment do
    puts "Checking for logger compatibility issues..."
    
    # Find activesupport gem
    begin
      gem_spec = Bundler.rubygems.find_name('activesupport').first
      if gem_spec
        gem_path = gem_spec.full_gem_path
        logger_thread_safe_level_file = File.join(gem_path, 'lib', 'active_support', 'logger_thread_safe_level.rb')
        
        if File.exist?(logger_thread_safe_level_file)
          puts "Found #{logger_thread_safe_level_file}"
          
          # Instead of patching, completely replace the file
          patched_content = <<~RUBY
            # frozen_string_literal: true

            # PATCHED FOR RUBY 3.1 COMPATIBILITY
            
            require "logger"
            
            module ActiveSupport
              # Implements the ActiveSupport::Logger::Silence extension for
              # thread safety in a logger level changes.
              module LoggerThreadSafeLevel
                # Define constants directly without using Logger::Severity
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
            
                def level
                  @level ||= DEBUG
                end
            
                def level=(level)
                  case level
                  when Integer
                    @level = level
                  when Symbol, String
                    @level = map_level(level)
                  else
                    raise ArgumentError, "Invalid log level: \#{level.inspect}"
                  end
                end
                
                def add(severity, message = nil, progname = nil, &block)
                  severity ||= UNKNOWN
                  return true if severity < local_level
                  super
                end
                
                def debug(progname = nil, &block)
                  add(DEBUG, nil, progname, &block)
                end
            
                def info(progname = nil, &block)
                  add(INFO, nil, progname, &block)
                end
            
                def warn(progname = nil, &block)
                  add(WARN, nil, progname, &block)
                end
            
                def error(progname = nil, &block)
                  add(ERROR, nil, progname, &block)
                end
            
                def fatal(progname = nil, &block)
                  add(FATAL, nil, progname, &block)
                end
            
                def unknown(progname = nil, &block)
                  add(UNKNOWN, nil, progname, &block)
                end
                
                private
                
                def map_level(level)
                  case level.to_s.downcase
                  when "debug" then DEBUG
                  when "info" then INFO
                  when "warn" then WARN
                  when "error" then ERROR
                  when "fatal" then FATAL
                  when "unknown" then UNKNOWN
                  else INFO
                  end
                end
              end
            end
          RUBY
          
          # Create a backup of the original file
          backup_file = "#{logger_thread_safe_level_file}.backup"
          File.write(backup_file, File.read(logger_thread_safe_level_file)) unless File.exist?(backup_file)
          
          # Write the completely new implementation
          File.write(logger_thread_safe_level_file, patched_content)
          puts "Successfully patched #{logger_thread_safe_level_file} for Ruby 3.1 compatibility"
        else
          puts "Could not find logger_thread_safe_level.rb"
        end
      else
        puts "Could not find activesupport gem"
      end
    rescue => e
      puts "Error patching logger: #{e.message}"
      puts e.backtrace.join("\n")
    end
    
    # Ensure the constants are defined
    puts "Ensuring Logger constants are defined globally..."
    Object.const_set(:DEBUG, 0) unless Object.const_defined?(:DEBUG)
    Object.const_set(:INFO, 1) unless Object.const_defined?(:INFO)
    Object.const_set(:WARN, 2) unless Object.const_defined?(:WARN)
    Object.const_set(:ERROR, 3) unless Object.const_defined?(:ERROR)
    Object.const_set(:FATAL, 4) unless Object.const_defined?(:FATAL)
    Object.const_set(:UNKNOWN, 5) unless Object.const_defined?(:UNKNOWN)
    
    # Ensure Logger::Severity exists
    unless ::Logger.const_defined?(:Severity)
      puts "Defining Logger::Severity module..."
      ::Logger.const_set(:Severity, Module.new)
      ::Logger::Severity.const_set(:DEBUG, 0)
      ::Logger::Severity.const_set(:INFO, 1)
      ::Logger::Severity.const_set(:WARN, 2)
      ::Logger::Severity.const_set(:ERROR, 3)
      ::Logger::Severity.const_set(:FATAL, 4)
      ::Logger::Severity.const_set(:UNKNOWN, 5)
      ::Logger.send(:include, ::Logger::Severity)
    end
    
    puts "Logger fixes completed!"
  end
end 