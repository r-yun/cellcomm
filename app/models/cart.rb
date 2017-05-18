class Cart < ApplicationRecord
  has_many :phones
  accepts_nested_attributes_for :phones
  has_one :user
end
