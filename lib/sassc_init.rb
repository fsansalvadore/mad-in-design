# SassC configuration to prevent segmentation faults on Heroku
# This file is loaded during Rails initialization

if defined?(SassC)
  ENV['SASSC_RAILS_ENABLE_SOURCEMAPS'] = 'false'
  # Disable sassc-rails verbose output
  SassC::Engine.instance_eval do
    def message_format(message)
      "#{message.capitalize}\n"
    end
  end
end 