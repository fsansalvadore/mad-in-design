# Early initializer that runs before all others to fix logger compatibility issues
# Uses underscore prefix to ensure it runs first

# Apply our global patch method if available
if defined?(patch_logger_thread_safe_level)
  patch_logger_thread_safe_level
end

# Define constants at the global level if not defined
Object.const_set(:DEBUG, 0) unless Object.const_defined?(:DEBUG)
Object.const_set(:INFO, 1) unless Object.const_defined?(:INFO)
Object.const_set(:WARN, 2) unless Object.const_defined?(:WARN)
Object.const_set(:ERROR, 3) unless Object.const_defined?(:ERROR)
Object.const_set(:FATAL, 4) unless Object.const_defined?(:FATAL)
Object.const_set(:UNKNOWN, 5) unless Object.const_defined?(:UNKNOWN)

# Direct patch for ActiveSupport::LoggerThreadSafeLevel if available
if defined?(ActiveSupport) && defined?(ActiveSupport::LoggerThreadSafeLevel)
  # Only patch if not already patched
  unless ActiveSupport::LoggerThreadSafeLevel.method_defined?(:patched_for_ruby31)
    # Define constants directly on the module
    ActiveSupport::LoggerThreadSafeLevel.const_set(:DEBUG, 0) unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:DEBUG)
    ActiveSupport::LoggerThreadSafeLevel.const_set(:INFO, 1) unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:INFO)
    ActiveSupport::LoggerThreadSafeLevel.const_set(:WARN, 2) unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:WARN)
    ActiveSupport::LoggerThreadSafeLevel.const_set(:ERROR, 3) unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:ERROR)
    ActiveSupport::LoggerThreadSafeLevel.const_set(:FATAL, 4) unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:FATAL)
    ActiveSupport::LoggerThreadSafeLevel.const_set(:UNKNOWN, 5) unless ActiveSupport::LoggerThreadSafeLevel.const_defined?(:UNKNOWN)
    
    # Patch the module methods
    ActiveSupport::LoggerThreadSafeLevel.module_eval do
      def local_level
        Thread.current["logger_#{object_id}_level"] || level
      end
      
      def local_level=(level)
        Thread.current["logger_#{object_id}_level"] = level
      end
      
      def patched_for_ruby31
        true
      end
    end
  end
end

# Make sure we're not loading redundant initializers
LOGGER_PATCHES_APPLIED = true 