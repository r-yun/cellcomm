class CartsController < ApplicationController

before_action :logged_in?, :only => [:cart]
def quantity
#phone info needs to be sent
end

  def create_cart
    @user = User.find(session[:user_id])
    puts @user.cart
    if @user.cart.nil?
      @cart = Cart.create
      @user.cart = @cart
      @user.save
    else
      @cart = @user.cart
    end

    @phone = Phone.find(params[:phone_id])
#if @phone.quantity == 0 do not run
    if @user.cart.phones.include?(@phone)
      puts "includes phone"
    else
      @user.cart.phones << @phone
      @user.save
    end

    redirect_to(cart_page_path)
    #check whether user has cart
    #if has cart, add to user.cart, if not create one and add it
    #send params quantity and phone id with redirect

  end

def cart
@user = User.find(session[:user_id])
end
  private

  def carts_params
    params.require(:cart)

  end
end
