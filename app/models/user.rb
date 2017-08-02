class User < ApplicationRecord
  has_secure_password
  has_many :orders
  belongs_to :address, {:optional => true}
  belongs_to :cart, {:optional => true}
  
  validates :first_name, :presence => true, :length => {:within => 2..30}, :on => :create
  validates :last_name, :presence => true, :length => {:within => 2..30}, :on => :create
  validates :email, :presence => true, :length => {:minimum => 2}
  validates :password, :presence => true, :length => {:within => 6..20}, :on => :create
  validates_uniqueness_of :username, :on => :create
  validates :username, :presence => true, :length => {:within => 4..15}, :on => :create



end
