require_relative 'boot'

# Load the logger patch before Rails
require_relative 'initializers/logger_patch'

require 'rails/all'

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
