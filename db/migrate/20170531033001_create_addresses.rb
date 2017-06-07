class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string "address"
      t.string "city"
      t.string "country"
      t.string "postal_code"
      t.string "province"
      t.timestamps
    end
  end
end
