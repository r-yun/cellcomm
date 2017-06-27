class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer "cart_id"
      t.integer "address_id"
      t.string "email"
      t.string "first_name"
      t.string "last_name"
      t.string "password_digest"
      t.string "username"
      t.timestamps
    end
  end
end
