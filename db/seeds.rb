puts 'Destroying users'
AdminUser.destroy_all
puts 'Finished destroying users'
puts 'Creating users'
AdminUser.create!(email: 'info@madindesign.com', password: 'madindesign', password_confirmation: 'madindesign')
AdminUser.create!(email: 'admin@madindesign.com', password: 'madindesign', password_confirmation: 'madindesign')
AdminUser.create!(email: 'content@madindesign.com', password: 'madindesign', password_confirmation: 'madindesign')
puts 'Finished creating users'
puts '======================='
