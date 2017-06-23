require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  before(:context){
    @created_user = User.create("username" => "test123", "password" => "pass123",
    "first_name" => "John", "last_name" => "Smith", "email" => "jsmith@hotmail.com")
    @phone = Phone.create("phone_name" => "iPhone 7 Plus", "brand_name" => "Apple",
    "price" => 1074.99, "quantity" => 4)
    @created_user.create_cart
  }

  after(:context){
    User.destroy_all
    Cart.destroy_all
    CartItem.destroy_all
    Phone.destroy_all
  }

  describe "calculate_totals (POST)" do
    before(:example){
      controller.instance_variable_set(:@user, @created_user)
      session[:user_id] = @created_user.id
      session[:username] = @created_user.username
    }

    it "updates total based on the price and quantity of the phone" do
      assigns(:user).cart.cart_items.create("quantity_sold" => 2, "phone" => @phone)
      post :calculate_totals
      expect(assigns(:subtotal)).to eq(2 * @phone.price)
      expect(assigns(:tax_total)).to eq(2 * @phone.price * 0.13)
      expect(assigns(:total)).to eq(assigns(:subtotal) + assigns(:tax_total))
    end
  end

  describe "cart_process (POST)" do
    before(:example){
      controller.instance_variable_set(:@user, @created_user)
      session[:user_id] = @created_user.id
      session[:username] = @created_user.username
    }

    it "updates the quantity sold for a particular phone" do
      @new_item =  assigns(:user).cart.cart_items.create(:quantity_sold => 4, :phone_id => @phone.id)
      post :cart_process, :params => {@phone.id => "2"}
      @user_items = assigns(:user).cart.cart_items
      expect(@user_items.length).to eq(1)
      expect(@user_items.first.phone.phone_name).to eq(@phone.phone_name)
      expect(@user_items.first.quantity_sold).to eq(2)
    end
  end

  describe "create_cart (POST)" do
    before(:example){
      controller.instance_variable_set(:@user, @created_user)
      session[:user_id] = @created_user.id
      session[:username] = @created_user.username
    }

    it "updates the quantity sold for a phone if the phone already exists in user's cart" do
      assigns(:user).cart.cart_items.create("phone_id" => @phone.id, "quantity_sold" => 1)
      post :create_cart, :params => {"quantity" => "3", "phone_id" => @phone.id}
      @user_items = assigns(:user).cart.cart_items
      expect(@user_items.length).to eq(1)
      expect(@user_items.first.phone.id).to eq(@phone.id)
      expect(@user_items.first.quantity_sold).to eq(3)
    end

    it "adds a phone to the user's cart if the phone does not already exist in it" do
      post :create_cart, :params => {"quantity" => "3", "phone_id" => @phone.id}
      @user_items = assigns(:user).cart.cart_items
      expect(@user_items.length).to eq(1)
      expect(@user_items.first.phone.id).to eq(@phone.id)
      expect(@user_items.first.quantity_sold).to eq(3)
    end
  end



  describe "order_submit (POST)" do
    before(:example){
      controller.instance_variable_set(:@user, @created_user)
      session[:user_id] = @created_user.id
      session[:username] = @created_user.username
      post :order_submit, :params => {@phone.id => "4"}
    }

    it "creates a single order and a single associated order item" do
      expect(assigns(:user).orders.length).to eq(1)
      expect(assigns(:user).orders.first.order_items.length).to eq(1)
    end

    it "creates an order with the phones and quantities selected by the user" do
      @user_items = assigns(:user).orders.first.order_items.first
      expect(@user_items.quantity_sold).to eq(4)
      expect(@user_items.phone.id).to eq(@phone.id)
    end

    it "empties the user cart after creating the order" do
      expect(assigns(:user).cart.cart_items.length).to eq(0)
    end
  end

  describe "remove_item (POST)" do
    before(:example){
      controller.instance_variable_set(:@user, @created_user)
      session[:user_id] = @created_user.id
      session[:username] = @created_user.username
    }

    it "deletes the selected phone from cart" do
      assigns(:user).cart.cart_items.create(:quantity_sold => 1, :phone => @phone)
      post :remove_item, :format => "js", :params => {:phone_id => @phone.id}
      expect(assigns(:user).cart.cart_items.length).to eq(0)
    end
  end

  describe "update_address (POST)" do
    before(:example){
      controller.instance_variable_set(:@user, @created_user)
      session[:user_id] = @created_user.id
      session[:username] = @created_user.username
    }

    it "updates the address of user in reponse to form fields" do
      post :update_address, :format => "js", :params => {"address"=>{"address"=>"333 Leaf Street",
      "city"=>"North York", "province"=>"Ontario", "country"=>"Canada",
      "postal_code"=>"l1l1l1"}}

      expect(assigns(:address)).to have_attributes("address"=>"333 Leaf Street",
      "city"=>"North York", "province"=>"Ontario", "country"=>"Canada",
      "postal_code"=>"l1l1l1")
    end
  end

end #RSpec.describe
