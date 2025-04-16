ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

# Load logger constants before anything else
require_relative '../lib/logger_constants'

require 'bundler/setup' # Set up gems listed in the Gemfile.

# Don't use bootsnap with Ruby 3.1+ for compatibility reasons
if RUBY_VERSION < "3.1"
  require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
end
