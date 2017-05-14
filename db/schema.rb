# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170514054652) do

  create_table "carts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "phones", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "battery"
    t.string   "back_camera"
    t.string   "brand_name"
    t.string   "front_camera"
    t.string   "image_1"
    t.string   "os"
    t.string   "phone_name"
    t.integer  "price"
    t.string   "price_category"
    t.integer  "quantity"
    t.string   "ram"
    t.datetime "release_date"
    t.string   "screen"
    t.string   "storage"
    t.string   "weight"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["brand_name"], name: "index_phones_on_brand_name", using: :btree
    t.index ["phone_name"], name: "index_phones_on_phone_name", using: :btree
    t.index ["price"], name: "index_phones_on_price", using: :btree
  end

  create_table "reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "phone_id"
    t.integer  "review_id"
    t.string   "title",      null: false
    t.integer  "rating",     null: false
    t.string   "review",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "last_name"
    t.string   "user_name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
