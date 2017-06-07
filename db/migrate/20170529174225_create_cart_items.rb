class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.integer "cart_id"
      t.integer "phone_id"
      t.integer "quantity_sold"
      t.timestamps
    end
  end
end
