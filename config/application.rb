require_relative 'boot'

# Explicitly require the logger library first
require 'logger'

# Load our critical pre-patch file before anything else
require_relative 'initializers/000_pre_logger_patches'

# Define global Logger constants to be available everywhere
DEBUG = 0 unless defined?(DEBUG)
INFO = 1 unless defined?(INFO)
WARN = 2 unless defined?(WARN)
ERROR = 3 unless defined?(ERROR)
FATAL = 4 unless defined?(FATAL)
UNKNOWN = 5 unless defined?(UNKNOWN)

# Ensure the Logger class is properly set up
if defined?(::Logger) && !::Logger.const_defined?(:Severity)
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

# Pre-define SimpleFormatter for Rails
module SimpleFormatterDefinition
  class SimpleFormatter < ::Logger::Formatter
    def call(severity, timestamp, progname, msg)
      "[#{timestamp.strftime("%Y-%m-%d %H:%M:%S.%L")}] #{severity} -- : #{msg}\n"
    end
  end
end

# Define this to prevent errors in ActiveSupport::LoggerThreadSafeLevel
LOGGER = ::Logger unless defined?(LOGGER)

# Load the Rails framework
require 'rails/all'

# Load our logger patches in specific order
require_relative 'initializers/simple_formatter_patch'
require_relative 'initializers/0_logger_patches'
require_relative 'initializers/active_support_logger'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MadInDesign
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}')]
    
    # Load custom configuration file
    config.before_initialize do
      require Rails.root.join('lib', 'custom_config')
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
