class UserForm

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

  delegate :address, :postal_code, :province, :country, :city, :to => :user_address
  delegate :first_name, :last_name, :email, :to => :user

  attr_reader :user, :user_address, :user_params, :address_params

  def initialize(current_user)
    @user = current_user
  end

  def user_address
    @user.address ||= @user.build_address
  end

  def assign_params(params)
    @user_params = params.slice(:first_name, :last_name, :email)
    @address_params = params.slice(:address, :city, :province, :country, :postal_code)
  end

  def submit(params)
    assign_params(params)
    @user.attributes = @user_params
    user_address.attributes = @address_params
    if valid?
        @user.save
        @user.address.save
      end
      true
    else
      @user.restore_attributes
      @user.address.restore_attributes
      false
    end


end
