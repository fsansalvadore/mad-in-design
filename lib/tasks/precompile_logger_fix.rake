# This rake task hooks into the Rails asset precompilation process
# It will run before assets:precompile to fix logger issues in Ruby 3.1
# and Node.js OpenSSL compatibility issues

# Hook into asset precompilation
if defined?(Rake::Task) && Rake::Task.task_defined?("assets:precompile")
  Rake::Task["assets:precompile"].enhance ["heroku:fix_logger", "heroku:fix_node"]
end 