class CartsController < ApplicationController

  before_action :logged_in?, :only => [:cart, :create_cart]
  before_action :user
  before_action :calculate_totals, :only => [:cart, :checkout]

  def calculate_totals
    phones_array = []
    if @user.cart.cart_items.present?
      @user.cart.cart_items.each do |item|
        phone_total = item.phone.price * item.quantity_sold
        phones_array << phone_total
    end
      @subtotal = phones_array.inject{|memo,n| memo + n}
      @tax_total = @subtotal * 0.13
      @total = @subtotal + @tax_total
    end
  end

  def cart
  end

  def cart_process
    params[:selection].each do |k, v|
      cart_item = @user.cart.cart_items.find_by(:phone_id => k)
      cart_item.update_attributes(:phone_id => k, :quantity_sold => v,
        :cart => @user.cart)
    end
    redirect_to(checkout_path)
  end


  def checkout
    @address = @user.address || @user.build_address
    @address_form = AddressForm.new(@address)
  end

  def create_cart
    @phone = Phone.find(params[:phone_id])
    return if @phone.quantity == 0
    if existing_item = @user.cart.cart_items.find_by(:phone_id => params[:phone_id].to_i)
      existing_item.update_attributes(:quantity_sold => params[:quantity])
    else
      @user.cart.cart_items.create(:phone_id => params[:phone_id],
        :quantity_sold => params[:quantity])
    end # if
    redirect_to(cart_page_path)
  end

  def order_submit
    # move to model with before_SAVE
    delivery_date = Time.now + 7.days #update delivery_date variable in view
    begin
      order_number = (0..8).map{[*0..9, *"A".."Z"].sample}.join
    end until Order.where(order_number: order_number).none?
    #better memory,
    ActiveRecord::Base.transaction do
      order = Order.create(:delivery_date => delivery_date, :order_number =>
        order_number, :user => @user)
      params[:selection].each do |k, v|
        order.order_items.create(:phone_id => k, :quantity_sold => v)
      end
      @user.cart.cart_items.destroy_all
    end
    redirect_to(user_page_path)
  end


  def remove_item
    cart_items = @user.cart.cart_items.where(:phone_id => params[:phone_id])
    cart_items.destroy_all
    calculate_totals
  end

  def update_address
    @address = @user.address || @user.build_address
    @address_form = AddressForm.new(@address)
    if @address_form.submit(address_params)
        calculate_totals
        flash.now[:notice] = "Address successfully saved"
    else
      respond_to do |format|
        format.js { render :partial => "address_only.js.erb" }
      end
    end
   end

  def update_price
     found_item = @user.cart.cart_items.find_by(:phone_id => params["phone-quantity"][0])
     found_item.update_attributes(:quantity_sold => params["phone-quantity"][1])
     calculate_totals
     render :partial => "cart_info.html.erb", :layout => false
  end

  private

  def address_params
    params.require(:address_form).permit(:address, :postal_code, :province, :country,
      :city, :user)
  end


end
