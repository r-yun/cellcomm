class CreateCartsPhonesJoin < ActiveRecord::Migration[5.0]
  def change
    create_table :carts_phones, :id => false do |t|
      t.integer "cart_id"
      t.integer "phone_id"
    end
    add_index("carts_phones", ["cart_id", "phone_id"])

  end
end
