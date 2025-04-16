# This file is used during Heroku deployment to specify the platform for the sassc gem
# to ensure it uses the binary version and doesn't try to compile from source
# Place this in the root directory of your Rails app

require 'net/http'
require 'json'
require 'fileutils'

# Check if we're running on Heroku
def on_heroku?
  ENV['DYNO']
end

if on_heroku?
  puts "Configuring sassc for Heroku deployment..."
  
  # Get Bundler's directory
  bundle_dir = ENV['BUNDLE_PATH'] || './vendor/bundle'
  
  # Create .bundle directory if it doesn't exist
  FileUtils.mkdir_p(File.join(Dir.pwd, '.bundle'))
  
  # Create config file
  config_path = File.join(Dir.pwd, '.bundle', 'config')
  
  # Read existing config if it exists
  config = if File.exist?(config_path)
    File.read(config_path)
  else
    ''
  end
  
  # Add platform-specific gem configuration
  unless config.include?('BUNDLE_FORCE_RUBY_PLATFORM')
    File.open(config_path, 'a') do |f|
      f.puts "\nBUNDLE_FORCE_RUBY_PLATFORM: 'true'"
    end
    puts "Added BUNDLE_FORCE_RUBY_PLATFORM: true to bundle config"
  end
  
  puts "SassC configuration complete."
end 