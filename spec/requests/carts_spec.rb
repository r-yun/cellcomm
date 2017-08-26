require 'rails_helper'


RSpec.describe "Carts", type: :request do
  before(:context){
    @phone = Phone.create("phone_name" => "iPhone 7 Plus", "brand_name" => "Apple",
      "price" => 1074.99, "quantity" => 4)
    post users_path, :params => {"user" => {"username" => "test123", "password" => "pass123",
      "first_name" => "John", "last_name" => "Smith", "email" => "jsmith@hotmail.com"}}
    post authentication_path, :params => {"username" => "test123", "password" => "pass123"}
  }

  after(:context){
    User.destroy_all
    Cart.destroy_all
    CartItem.destroy_all
    Phone.destroy_all
  }

  describe "It calculates totals from various cart items" do
    before(:example){ post authentication_path, :params => {"username" => "test123", "password" => "pass123"}}

    it "updates total based on the price and quantity of the phone" do
      post create_cart_path, :params => {"quantity" => "2", "phone_id" => @phone.id}
      post calculate_totals_path
      expect(assigns(:subtotal)).to eq(2 * @phone.price)
      expect(assigns(:tax_total)).to eq(2 * @phone.price * 0.13)
      expect(assigns(:total)).to eq(assigns(:subtotal) + assigns(:tax_total))
    end
  end


  describe "cart_process (POST)" do
    before(:example) { post authentication_path, :params => {"username" => "test123", "password" => "pass123"} }
    it "updates the quantity sold for a particular phone" do
      post create_cart_path, :params => {"quantity" => "4", "phone_id" => @phone.id}
      post cart_process_path, :params => {"selection" => {@phone.id => "2"}}
      @user_items = assigns(:user).cart.cart_items
      expect(@user_items.length).to eq(1)
      expect(@user_items.first.phone).to eq(@phone)
      expect(@user_items.first.quantity_sold).to eq(2)
    end
  end

  describe "create_cart (POST)" do
    before(:example) { post authentication_path, :params => {"username" => "test123", "password" => "pass123"} }
    it "updates the quantity sold for a phone if the phone already exists in user's cart" do
      post create_cart_path, :params => {"quantity" => "2", "phone_id" => @phone.id}
      post create_cart_path, :params => {"quantity" => "3", "phone_id" => @phone.id}
      @user_items = assigns(:user).cart.cart_items
      expect(@user_items.length).to eq(1)
      expect(@user_items.first.phone.id).to eq(@phone.id)
      expect(@user_items.first.quantity_sold).to eq(3)
    end

    it "adds a phone to the user's cart if the phone does not already exist in it" do
      post create_cart_path, :params => {"quantity" => "3", "phone_id" => @phone.id}
      @user_items = assigns(:user).cart.cart_items
      expect(@user_items.length).to eq(1)
      expect(@user_items.first.phone.id).to eq(@phone.id)
      expect(@user_items.first.quantity_sold).to eq(3)
    end
  end

  describe "order_submit (POST)" do
    before(:example) do
      post authentication_path, :params => {"username" => "test123", "password" => "pass123"}
      post order_submit_path, :params => {"selection" => {@phone.id => "4"}}
    end

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
    before(:example) { post authentication_path, :params => {"username" => "test123", "password" => "pass123"} }

    it "deletes the selected phone from cart" do
      post create_cart_path, :params => {"quantity" => "3", "phone_id" => @phone.id}
      post remove_item_path, :xhr => true, :params => {:phone_id => @phone.id}
      expect(assigns(:user).cart.cart_items.length).to eq(0)
    end
  end

  describe "update_address (POST)" do
    before(:example) { post authentication_path, :params => {"username" => "test123", "password" => "pass123"} }

    it "updates the address of user in reponse to form fields" do
     post update_address_path, :xhr => true, :params => {"address_form"=>{"address"=>"333 Leaf Street",
        "city"=>"North York", "province"=>"Ontario", "country"=>"Canada",
        "postal_code"=>"l1l1l1"}}

      expect(assigns(:address)).to have_attributes("address"=>"333 Leaf Street",
        "city"=>"North York", "province"=>"Ontario", "country"=>"Canada",
        "postal_code"=>"l1l1l1")
    end
  end

  describe "update_price (POST)" do
    before(:example) { post authentication_path, :params => {"username" => "test123", "password" => "pass123"} }

    it "updates total based on the price and quantity of the phone" do
      post create_cart_path, :params => {"quantity" => "2", "phone_id" => @phone.id}
      post update_price_path, :params => {"phone-quantity" => [@phone.id, 3]}
      expect(assigns(:subtotal)).to eq(3 * @phone.price)
      expect(assigns(:tax_total)).to eq(3 * @phone.price * 0.13)
      expect(assigns(:total)).to eq(assigns(:subtotal) + assigns(:tax_total))
    end
  end
end
