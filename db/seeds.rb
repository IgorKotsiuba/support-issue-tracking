User.destroy_all
manager1 = User.create!(email: 'manager1@example.com', password: 'password', role: :manager, username: 'manager1')
puts 'Manager 1: manager1/password'
manager2 = User.create!(email: 'manager2@example.com', password: 'password', role: :manager, username: 'manager2')
puts 'Manager 2: manager2/password'

['Waiting for Staff Response', 'Waiting for Customer', 'On Hold', 'Cancelled', 'Completed'].each do |status|
  Status.create(name: status)
end
