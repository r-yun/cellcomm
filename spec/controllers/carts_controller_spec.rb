require 'rails_helper'

RSpec.describe CartsController, type: :controller do
before(:context){
  @created_user = User.create("username" => "test123", "password" => "pass123",
  "first_name" => "John", "last_name" => "Smith", "email" => "jsmith@hotmail.com")
  @phone = Phone.create(:phone_name => "iPhone 7 Plus", :brand_name => "Apple",
  :price => 1074.99, :quantity => 4)
  @created_user.create_cart
}

after(:context){
  User.destroy_all
  Phone.destroy_all
  Cart.destroy_all
  CartItem.destroy_all
  #USer, Phone, Cart, CartItem deleting TEST database, need to destroy in development database...
  #without actually deleting development data. set controller.instance_variable_set(var, to deleted var?)

}


  describe "create_cart (POST)" do
    before(:example){
    controller.instance_variable_set(:@user, @created_user)
    session[:user_id] = @created_user.id
    session[:username] = @created_user.username
    @user_items = assigns(:user).cart.cart_items
  }

  after(:example){
    @user_items.destroy_all
  }
  it "updates quantity sold if phone already exists in user's cart" do
    @user_items.create(:phone_id => @phone.id, :quantity_sold => 1)
    post :create_cart, :params => {"quantity" => "3", "phone_id" => @phone.id}
    expect(@user_items.length).to eq(1)
    expect(@user_items.first.phone.id).to eq(@phone.id)
    expect(@user_items.first.quantity_sold).to eq(3)
  end

  it "creates a new cart item if no phone exists in the user'scart" do
    post :create_cart, :params => {"quantity" => "3", "phone_id" => @phone.id}
    @user_items = assigns(:user).cart.cart_items
    expect(@user_items.length).to eq(1)
    expect(@user_items.first.phone.id).to eq(@phone.id)
    expect(@user_items.first.quantity_sold).to eq(3)
  end


end

describe "calculate_totals (POST)" do
  before(:example){
    controller.instance_variable_set(:@user, @created_user)
    session[:user_id] = @created_user.id
    session[:username] = @created_user.username
    }


    after(:example){
      assigns(:user).cart.cart_items.destroy_all
    }
  it "updates total based on amount of phones" do
    assigns(:user).cart.cart_items.create(:quantity_sold => 1, :phone => @phone)
    post :calculate_totals
    expect(assigns(:subtotal)).to eq(@phone.price)
    expect(assigns(:tax_total)).to eq(@phone.price * 0.13)
    expect(assigns(:total)).to eq(assigns(:subtotal) + assigns(:tax_total))
    assigns(:user).cart.cart_items.destroy_all
  end


end

describe "cart_process (POST)" do
  before(:example){
   controller.instance_variable_set(:@user, @created_user)
   session[:user_id] = @created_user.id
   session[:username] = @created_user.username
    }

  it "updates quantity_sold" do
   @new_item =  assigns(:user).cart.cart_items.create(:quantity_sold => 1, :phone => @phone)
    controller.instance_variable_set(:@params_hash, @new_item)
    post :cart_process, :params => {:@phone_id => "2"}
    expect(assigns(:user).cart.cart_items.first.quantity_sold).to eq(2)

  end
end


# describe "remove_item (POST)" do
#   before(:example){
#     controller.instance_variable_set(:@user, @created_user)
#     session[:user_id] = @created_user.id
#     session[:username] = @created_user.username
#     assigns(:user).cart.cart_items.destroy_all
#
#     }
#
#   it "deletes phone from cart" do
#     @user_items = assigns(:user).cart.cart_items
#     expect(assigns(:user).cart.cart_items.length).to eq(0)
#     @user_items.create(:quantity_sold => 1, :phone => @phone)
#     expect(assigns(:user).cart.cart_items.length).to eq(1)
#     puts @phone.id.to_yaml
#     @found_phone = Phone.find(@phone.id)
#     post :remove_item, :params => {:phone_id => @phone.id}, :xhr => true
#     controller.instance_variable_set(:@delete_phone, @found_phone)
#     controller.instance_variable_set(:@cart_items, @found_phone)
#     puts @cart_items.phone_name
#     expect(@user_items.length).to eq(0)
#
#   end
# end
#



end
