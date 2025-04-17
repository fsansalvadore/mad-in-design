require 'rails/railtie'

module MadInDesign
  class LoggerPatchRailtie < Rails::Railtie
    # This runs before any initializers
    config.before_configuration do
      # Ensure the Logger class and its constants are properly defined
      require 'logger'

      # Define global constants if they don't exist
      Object.const_set(:DEBUG, 0) unless Object.const_defined?(:DEBUG)
      Object.const_set(:INFO, 1) unless Object.const_defined?(:INFO)
      Object.const_set(:WARN, 2) unless Object.const_defined?(:WARN)
      Object.const_set(:ERROR, 3) unless Object.const_defined?(:ERROR)
      Object.const_set(:FATAL, 4) unless Object.const_defined?(:FATAL)
      Object.const_set(:UNKNOWN, 5) unless Object.const_defined?(:UNKNOWN)

      # Ensure Logger::Severity exists
      unless ::Logger.const_defined?(:Severity)
        ::Logger.const_set(:Severity, Module.new)
        ::Logger::Severity.const_set(:DEBUG, 0)
        ::Logger::Severity.const_set(:INFO, 1)
        ::Logger::Severity.const_set(:WARN, 2)
        ::Logger::Severity.const_set(:ERROR, 3)
        ::Logger::Severity.const_set(:FATAL, 4)
        ::Logger::Severity.const_set(:UNKNOWN, 5)
        ::Logger.send(:include, ::Logger::Severity)
      end

      # Direct monkey patch for ActiveSupport::LoggerThreadSafeLevel
      if defined?(ActiveSupport) && defined?(ActiveSupport::LoggerThreadSafeLevel)
        module ActiveSupport
          module LoggerThreadSafeLevel
            # Remove constants if they exist to avoid warnings
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
            def local_level
              Thread.current["logger_#{object_id}_level"] || level
            end

            def local_level=(level)
              Thread.current["logger_#{object_id}_level"] = level
            end
          end
        end
      end
    end
  end
end 