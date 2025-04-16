ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.

# Load the logger patch early to avoid initialization errors
require_relative 'initializers/logger_patch'

# Don't use bootsnap with Ruby 3.1+ for compatibility reasons
if RUBY_VERSION < "3.1"
  require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
end
