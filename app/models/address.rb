class Address < ApplicationRecord
  has_one :user
  validates_presence_of :address
  validates_presence_of :city
  validates :postal_code, :presence => true, :length => {:within => 6..7}
  validates_presence_of :province
  validates_presence_of :country
end
