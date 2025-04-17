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
          content = File.read(logger_thread_safe_level_file)
          
          if content.include?('Logger::Severity.constants.each') && !content.include?('# PATCHED FOR RUBY 3.1')
            puts "Patching LoggerThreadSafeLevel..."
            
            # Create a backup
            File.write("#{logger_thread_safe_level_file}.backup", content)
            
            # Replace the problematic code
            patched_content = content.gsub(
              /Logger::Severity\.constants\.each do \|severity\|.*?end/m,
              <<-PATCH
      # PATCHED FOR RUBY 3.1
      # Define constants directly
      DEBUG = 0
      INFO = 1
      WARN = 2
      ERROR = 3
      FATAL = 4
      UNKNOWN = 5
      PATCH
            )
            
            File.write(logger_thread_safe_level_file, patched_content)
            puts "Successfully patched #{logger_thread_safe_level_file}"
          else
            puts "File does not need patching or already patched"
          end
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
    
    # Also monkey patch ActiveSupport::LoggerThreadSafeLevel
    if defined?(ActiveSupport) && defined?(ActiveSupport::LoggerThreadSafeLevel)
      puts "Monkey patching ActiveSupport::LoggerThreadSafeLevel..."
      
      module ActiveSupport
        module LoggerThreadSafeLevel
          unless @patched_for_ruby31
            # Remove constants to avoid warnings
            constants.grep(/^(DEBUG|INFO|WARN|ERROR|FATAL|UNKNOWN)$/).each do |const|
              remove_const(const) if const_defined?(const)
            end
            
            # Define constants directly
            const_set(:DEBUG, 0)
            const_set(:INFO, 1)
            const_set(:WARN, 2)
            const_set(:ERROR, 3)
            const_set(:FATAL, 4)
            const_set(:UNKNOWN, 5)
            
            # Override methods
            define_method(:local_level) do
              Thread.current["logger_#{object_id}_level"] || level
            end
            
            define_method(:local_level=) do |level|
              Thread.current["logger_#{object_id}_level"] = level
            end
            
            @patched_for_ruby31 = true
          end
        end
      end
    end
    
    puts "Logger fixes completed!"
  end
end 