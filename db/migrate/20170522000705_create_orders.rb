class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.datetime "delivery_date"
      t.string "order_number"
      t.integer "user_id"
      t.timestamps
    end
  end
end
