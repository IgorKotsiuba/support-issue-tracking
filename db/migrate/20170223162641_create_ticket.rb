class CreateTicket < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :subject, null: false
      t.string :reference_number, null: false
      t.integer :customer_id, null: false
      t.integer :manager_id
      t.integer :status_id, null: false

      t.timestamps
    end

    add_index :tickets, :reference_number, unique: true
  end
end
