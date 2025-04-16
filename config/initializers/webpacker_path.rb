# Ensure webpack is in the PATH for Webpacker
if Rails.env.production?
  webpack_bin = Rails.root.join('node_modules', '.bin')
  ENV['PATH'] = "#{webpack_bin}:#{ENV['PATH']}"
  puts "Added #{webpack_bin} to PATH for Webpacker"
end 