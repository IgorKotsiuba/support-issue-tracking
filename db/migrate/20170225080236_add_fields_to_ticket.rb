class AddFieldsToTicket < ActiveRecord::Migration[5.0]
  def change
    remove_column :tickets, :customer_id, :integer
    rename_column :tickets, :manager_id, :user_id
    add_column :tickets, :customer_name, :string, null: false
    add_column :tickets, :customer_email, :string, null: false
    add_column :tickets, :issue_department, :string
    add_column :tickets, :url_token, :string, null: false
    add_index :tickets, :url_token, unique: true
  end
end
