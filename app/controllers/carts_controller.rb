class CartsController < ApplicationController

before_action :logged_in?, :only => [:cart, :create_cart]
before_action :user
def quantity
#phone info needs to be sent
end

  def create_cart
    @phone = Phone.find(params[:phone_id])
    #if @phone.quantity == 0 do not run

  unless @phone.quantity == 0
  user_items = @user.cart.cart_items
  if user_items.any?{|x| x.phone_id == params[:phone_id].to_i}
    user_items.each do |x|
      if x.phone_id == params[:phone_id].to_i
        x.update_attributes(:quantity_sold => params[:quantity].to_i)
        break
      end
    end
  else
  @new_item = CartItem.new(:phone_id => params[:phone_id].to_i, :quantity_sold => params[:quantity].to_i)
  user_items << @new_item
  @new_item.save
  puts "created new cart_item"
  end
  end
  session["phone_" + params[:phone_id]] =  params[:quantity]
  puts session["phone_" + params[:phone_id]]
  redirect_to(cart_page_path)


    #check whether user has cart
    #if has cart, add to user.cart, if not create one and add it
    #send params quantity and phone id with redirect

  end

  def user
    @user = User.find(session[:user_id])
  end

  def update_address
    @address = @user.address
    if @address.update_attributes(address_params)
      flash.now[:notice] = "Address successfully saved"
    else
    end
  end

#figure out why certain page caches so much (likely session[])
def cart
end
def cart_process
@phones = Phone.all
params_hash = params.slice(*[*"1"..@phones.length.to_s])
params_hash.each do |k,v|
  cart_item = @user.cart.cart_items.where(:phone_id => k).first
  cart_item.update_attributes(:phone_id => k, :quantity_sold => v, :cart => @user.cart)
end
 redirect_to(checkout_path)
end

def checkout
@address = @user.address
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
      order_item.order = order #put in orderitem.create
      order_item.save
  end

  order.update_attributes(:delivery_date => delivery_date, :order_number =>
  order_number, :user_id => session[:user_id])

  #set cart to nil
  @user.cart.cart_items.destroy_all
redirect_to(user_page_path)
end

def remove_item
  @delete_phone = Phone.find(params[:phone_id])
  @user.cart.cart_items.where(:phone_id => params[:phone_id]).destroy_all
end
  private

  def carts_params
    params.require(:cart)
  end

    def address_params
      params.require(:address).permit(:address, :postal_code, :province, :country, :city)
    end
end
