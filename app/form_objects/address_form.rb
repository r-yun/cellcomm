class AddressForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  delegate :address, :city, :postal_code, :province, :country, :to => :address_model

  validates_presence_of :address
  validates_presence_of :city
  validates :postal_code, presence: true, :length => {:within => 6..7}
  validates_presence_of :province
  validates_presence_of :country

  def initialize(address)
    @address = address
  end
  def address_model
    @address
  end

  def submit(params)
    @address.attributes = params
    if valid?
      @address.save
      @address.user.update_attributes(:address => @address)
      true
    else
      @address.restore_attributes
      false
    end
  end


end
