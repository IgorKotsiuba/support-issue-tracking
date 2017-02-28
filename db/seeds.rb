User.destroy_all
manager1 = User.create!(email: 'manager1@example.com', password: 'password', role: :manager, username: 'manager1')
puts 'Manager 1: manager1/password'
manager2 = User.create!(email: 'manager2@example.com', password: 'password', role: :manager, username: 'manager2')
puts 'Manager 2: manager2/password'

['Waiting for Staff Response', 'Waiting for Customer', 'On Hold', 'Cancelled', 'Completed'].each do |name|
  status = Status.create(name: name)
  2.times do
    ticket = status.tickets.create(
      customer_name: 'Joe Doe', customer_email: 'joe@example.com', subject: 'Internet Problem'
    )
    ticket.messages.create(body: 'Need help')
  end
end
