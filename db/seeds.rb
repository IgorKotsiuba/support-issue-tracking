manager1 = User.create!(email: 'manager1@example.com', password: 'password', role: :manager)
puts 'Manager 1: manager1@example.com'
manager2 = User.create!(email: 'manager2@example.com', password: 'password', role: :manager)
puts 'Manager 2: manager2@example.com'

['Waiting for Staff Response', 'Waiting for Customer', 'On Hold', 'Cancelled', 'Completed'].each do |status|
  Status.create(name: status)
end
