# Direct patch for ActiveSupport::LoggerThreadSafeLevel class
# This patch will be applied to the actual gem code

# First, check if the gem path is accessible
gem_path = nil
if defined?(Bundler)
  begin
    gem_spec = Bundler.rubygems.find_name('activesupport').first
    gem_path = gem_spec.full_gem_path if gem_spec
  rescue
    # If this fails, we'll try alternate approaches
  end
end

# Try to find the file we need to patch
logger_thread_safe_level_file = nil
if gem_path
  logger_thread_safe_level_file = File.join(gem_path, 'lib', 'active_support', 'logger_thread_safe_level.rb')
end

# If we found the file, patch it directly
if logger_thread_safe_level_file && File.exist?(logger_thread_safe_level_file)
  # Read the current content
  content = File.read(logger_thread_safe_level_file)
  
  # Only patch if it contains the problematic code
  if content.include?('Logger::Severity.constants.each') && !content.include?('# PATCHED FOR RUBY 3.1')
    # Create a backup
    backup_file = "#{logger_thread_safe_level_file}.backup"
    File.write(backup_file, content) unless File.exist?(backup_file)
    
    # Replace the problematic code
    patched_content = content.gsub(
      /Logger::Severity\.constants\.each do \|severity\|.*?end/m,
      <<-REPLACEMENT
      # PATCHED FOR RUBY 3.1
      # Define constants directly
      DEBUG = 0
      INFO = 1
      WARN = 2
      ERROR = 3
      FATAL = 4
      UNKNOWN = 5
      REPLACEMENT
    )
    
    # Write the patched content back
    File.write(logger_thread_safe_level_file, patched_content)
    
    # Log that we've patched the file
    puts "Successfully patched #{logger_thread_safe_level_file} for Ruby 3.1 compatibility"
  end
end 