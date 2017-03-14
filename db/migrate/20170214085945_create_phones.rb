class CreatePhones < ActiveRecord::Migration[5.0]
  def change
    create_table :phones do |t|
      t.datetime "release_date"
      t.string "ram"
      t.string "battery"
      t.string "weight"
      t.string "front_camera"
      t.string "back_camera"
      t.string "storage"
      t.string "brand_name"
      t.string "phone_name"
      t.string "screen"
      t.string "os"
      t.string "price"
      t.timestamps
    end
    add_index("phones", "brand_name")
    add_index("phones", "price")
    add_index("phones", "phone_name")
  end
end
