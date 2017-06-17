class Cart < ApplicationRecord
  has_and_belongs_to_many :phones
  has_one :user
  has_many :cart_items




end
