class CreatePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :phones do |t|
      t.string "battery"
      t.string "back_camera"
      t.string "brand_name"
      t.string "front_camera"
      t.string "image_1"
      t.string "os"
      t.string "phone_name"
      t.integer "price"
      t.string "price_category"
      t.integer "quantity"
      t.string "ram"
      t.datetime "release_date"
      t.string "screen"
      t.string "storage"
      t.timestamps
    end
    add_index("phones", "brand_name")
    add_index("phones", "price")
    add_index("phones", "phone_name")
  end
end
