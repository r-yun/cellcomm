class AddressForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  delegate :address, :city, :postal_code, :province, :country, :to => :address_model

  validates_presence_of :address
  validates_presence_of :city
  validates :postal_code, :presence => true, :length => {:within => 6..7}
  validates_presence_of :province
  validates_presence_of :country



  attr_reader :assign_params

  def initialize(address)
    @address = address
  end

  def address_model
    @address
  end

  def submit(params)
    prev_address = @address.attributes
    @address.attributes = params
    #try @user.new().valid
    if valid?
      @address.save
      true
    else
      @address.attributes = prev_address
      false
    end
  end


end
