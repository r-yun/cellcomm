class User < ApplicationRecord
  has_secure_password
  has_many :orders
  belongs_to :address, {:optional => true}
  belongs_to :cart, {:optional => true}
  accepts_nested_attributes_for :address
  validates :first_name, :presence => true, :length => {:within => 2..30}
  validates :last_name, :presence => true, :length => {:within => 2..30}
  validates :password, :presence => true, :length => {:within => 6..20}, unless: :skip_password_validation
  validates_uniqueness_of :username, :scope => :user_id
  validates :username, :presence => true, :length => {:within => 4..15}
  attr_accessor :skip_user_validation, :skip_password_validation
end
