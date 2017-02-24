class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body, null: false
      t.references :ticket, index: true
      t.references :user, index: true
      t.boolean :read, default: false
    end
  end
end
