class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer "phone_id"
      t.integer "review_id"
      t.string "title", :null => false
      t.integer "rating", :null => false
      t.string "review", :null => false
      t.timestamps
    end
  end
end
