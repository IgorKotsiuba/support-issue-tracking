manager1 = User.create!(email: 'manager1@example.com', password: 'password', role: :manager)
puts 'Manager 1: manager1@example.com'
manager2 = User.create!(email: 'manager2@example.com', password: 'password', role: :manager)
puts 'Manager 2: manager2@example.com'
customer1 = User.create!(email: 'customer1@example.com', role: :customer)
puts 'Customer 1: customer1@example.com'

['Waiting for Staff Response', 'Waiting for Customer', 'On Hold', 'Cancelled', 'Completed'].each do |status|
  Status.create(name: status)
end
