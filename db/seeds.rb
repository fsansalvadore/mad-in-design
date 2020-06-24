puts 'Destroying users'
AdminUser.destroy_all
puts 'Finished destroying users'
puts 'Creating users'
AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456')
puts 'Finished creating users'
