class CartsController < ApplicationController

  before_action :logged_in?, :only => [:cart, :create_cart]
  before_action :user

  def create_cart
    @phone = Phone.find(params[:phone_id])
    unless @phone.quantity == 0
      user_items = @user.cart.cart_items
      if user_items.any?{|x| x.phone_id == params[:phone_id].to_i}
        user_items.each do |x|
          if x.phone_id == params[:phone_id].to_i
            x.update_attributes(:quantity_sold => params[:quantity].to_i)
            break
          end #if
        end #user_items.each
      else
        @new_item = CartItem.new(:phone_id => params[:phone_id].to_i, :quantity_sold => params[:quantity].to_i)
        user_items << @new_item
        @new_item.save
      end #if
      redirect_to(cart_page_path)
    end #unless
  end #create_cart

  def cart
    calculate_totals
  end

  def update_address
    @address = @user.address
    if @address.update_attributes(address_params)
      flash.now[:notice] = "Address successfully saved"
    else
    end
  end

  #figure out why certain page caches so much (likely session[])


  def cart_process
    @phones = Phone.all
    @params_hash = params.slice(*[*"1"..@phones.length.to_s])
    @params_hash.each do |k,v|
      @cart_item = @user.cart.cart_items.where(:phone_id => k).first
      @cart_item.update_attributes(:phone_id => k, :quantity_sold => v, :cart => @user.cart)
    end
    redirect_to(checkout_path)
  end

  def checkout
    @address = @user.address
    calculate_totals
  end

  def order_submit
    @phones = Phone.all
    delivery_date = Time.now + 7.days
    order_number = (0..8).map{[*0..9, *"A".."Z"].sample}.join

    order = Order.create(:delivery_date => delivery_date, :order_number =>
    order_number, :user_id => @user)

    params_hash = params.slice(*[*"1"..@phones.length.to_s])
    params_hash.each do |k,v|
      order_item = OrderItem.create(:phone_id => k, :quantity_sold => v)
      order_item.order = order
      order_item.save
    end
    order.update_attributes(:delivery_date => delivery_date, :order_number =>
    order_number, :user_id => session[:user_id])
    @user.cart.cart_items.destroy_all
    redirect_to(user_page_path)
  end

  def remove_item
    @delete_phone = Phone.find(params[:phone_id])
    @cart_items = @user.cart.cart_items.where(:phone_id => params[:phone_id])
    @cart_items.destroy_all
    calculate_totals
  end

  def calculate_totals
    phones_array = []
    @user = User.find(session[:user_id])
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

  private

  def address_params
    params.require(:address).permit(:address, :postal_code, :province, :country, :city)
  end



end
