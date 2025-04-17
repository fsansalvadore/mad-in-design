ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

# Explicitly require the logger library before anything else
require 'logger'

# Load our direct logger fix, which is much simpler and doesn't have syntax issues
require_relative '../lib/direct_logger_fix'

require 'bundler/setup' # Set up gems listed in the Gemfile.

# Don't use bootsnap with Ruby 3.1+ for compatibility reasons
if RUBY_VERSION < "3.1"
  require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
end
