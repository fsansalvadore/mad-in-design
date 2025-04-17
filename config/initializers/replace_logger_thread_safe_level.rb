# This initializer replaces the problematic ActiveSupport::LoggerThreadSafeLevel file
# with our patched version during application initialization

# First, find the activesupport gem path
begin
  activesupport_gem = nil
  if defined?(Bundler)
    activesupport_gem = Bundler.rubygems.find_name('activesupport').first
  end

  if activesupport_gem
    gem_path = activesupport_gem.full_gem_path
    target_file = File.join(gem_path, 'lib', 'active_support', 'logger_thread_safe_level.rb')
    
    if File.exist?(target_file)
      # Read our patched version
      our_patch_file = Rails.root.join('lib', 'patches', 'active_support', 'logger_thread_safe_level.rb')
      
      if File.exist?(our_patch_file)
        patched_content = File.read(our_patch_file)
        original_content = File.read(target_file)
        
        # Only replace if it hasn't been patched already
        unless original_content.include?('# PATCHED FOR RUBY 3.1')
          # Create a backup of the original file
          backup_file = "#{target_file}.original"
          File.write(backup_file, original_content) unless File.exist?(backup_file)
          
          # Replace the file with our patched version
          File.write(target_file, patched_content)
          
          Rails.logger.info "Replaced #{target_file} with patched version for Ruby 3.1 compatibility"
        end
      end
    end
  end
rescue => e
  # Don't let errors here prevent app initialization
  Rails.logger.error "Failed to patch logger_thread_safe_level.rb: #{e.message}" if defined?(Rails) && Rails.logger
end

# Directly monkey patch ActiveSupport::LoggerThreadSafeLevel to ensure it's properly patched
# regardless of whether the file replacement worked
if defined?(ActiveSupport) && defined?(ActiveSupport::LoggerThreadSafeLevel)
  module ActiveSupport
    module LoggerThreadSafeLevel
      unless @patched_for_ruby31
        # Remove constants if they exist
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
        
        # Define the problematic methods
        def local_level
          Thread.current["logger_#{object_id}_level"] || level
        end
        
        def local_level=(level)
          Thread.current["logger_#{object_id}_level"] = level
        end
        
        @patched_for_ruby31 = true
      end
    end
  end
end 