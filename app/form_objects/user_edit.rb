class UserEdit

  extend ActiveModel::Naming
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations


  validates :first_name, :presence => true, :length => {:within => 2..30}
  validates :last_name, :presence => true, :length => {:within => 2..30}
  validates :email, :presence => true, :length => {:minimum => 2}
  validates_presence_of :address
  validates_presence_of :city
  validates :postal_code, :presence => true, :length => {:within => 6..7}
  validates_presence_of :province
  validates_presence_of :country

  # delegating to set variables within the form
  delegate :address, :postal_code, :province, :country, :city, :to => :user_address
  delegate :first_name, :last_name, :email, :to => :user

  attr_reader :user, :user_params, :address_params

  def initialize(current_user)
    @user = current_user
  end

  def user_address
    @user.address || @user.build_address
  end

  def assign_params(params)
    params.permit!
    @user_params = params.slice(:first_name, :last_name, :email)
    @address_params = params.slice(:address, :city, :province, :country, :postal_code)
  end

  def submit
    prev_user = @user.attributes
    prev_address = @user.address.attributes
    @user.attributes = @user_params
    @user.address.attributes = @address_params
    if valid?
      @user.save
      @user.address.save
      true
    else
      @user.attributes = prev_user
      @user.address.attributes = prev_address
      false
    end
  end


end
