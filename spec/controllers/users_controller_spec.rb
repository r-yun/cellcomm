require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "create (POST)" do
    it "creates new user with a cart and address associated with it" do
    post :create, :params => {"user"=>{"username" => "test123", "password" => "pass123",
    "first_name" => "John", "last_name" => "Smith", "email" => "jsmith@hotmail.com"}}

    expect(assigns(:new_user)).to have_attributes("username" => "test123", "password" => "pass123",
    "first_name" => "John", "last_name" => "Smith", "email" => "jsmith@hotmail.com")

    expect(assigns(:new_user).cart).to be_truthy
    expect(assigns(:new_user).address).to be_truthy
    end
  end

  describe "user_edit (POST)" do
    before(:example){
      @created_user = User.create("username" => "test123", "password" => "pass123",
      "first_name" => "John", "last_name" => "Smith", "email" => "jsmith@hotmail.com")
      @created_user.create_cart
      controller.instance_variable_set(:@user, @created_user)
      session[:user_id] = @created_user.id
      session[:username] = @created_user.username
    }

    it "edits a user's information through form fields" do
      post :user_edit, :format => "js", :params => {"user"=>{"first_name"=>"John", "last_name"=>"Smith",
      "email"=>"jsmith@hotmail.com", "address_attributes"=>{"address"=>"123 Leaf Street", "city"=>"Toronto",
      "province"=>"Ontario", "country"=>"Canada", "postal_code"=>"m1m1m1"}}}

      expect(assigns(:user)).to have_attributes("first_name"=>"John", "last_name"=>"Smith",
      "email"=>"jsmith@hotmail.com")

      expect(assigns(:user).address).to have_attributes("address"=>"123 Leaf Street", "city"=>"Toronto",
      "province"=>"Ontario", "country"=>"Canada", "postal_code"=>"m1m1m1")
    end
  end
end
