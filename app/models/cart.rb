class Cart < ApplicationRecord
  has_one :user
  has_many :cart_items
end
