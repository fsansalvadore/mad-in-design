# This rake task hooks into the Rails asset precompilation process
# It will run before assets:precompile to fix logger issues in Ruby 3.1

# Hook into asset precompilation
Rake::Task["assets:precompile"].enhance ["heroku:fix_logger"] if defined?(Rake::Task) && Rake::Task.task_defined?("assets:precompile") 