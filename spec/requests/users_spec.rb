require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "create (POST)" do
    it "creates new user with a cart" do
    post users_path, :params => {"user"=>{"username" => "test123", "password" => "pass123",
      "first_name" => "John", "last_name" => "Smith", "email" => "jsmith@hotmail.com"}}
    expect(assigns(:new_user)).to have_attributes("username" => "test123", "password" => "pass123",
      "first_name" => "John", "last_name" => "Smith", "email" => "jsmith@hotmail.com")
    expect(assigns(:new_user).cart.id).to be_truthy
    end
  end

  describe "user_edit (POST)" do
    before(:example) do
      post users_path, :params => {"user"=>{"username"=>"test123", "password"=>"pass123",
        "first_name" => "John", "last_name" => "Smith", "email" => "jsmith@hotmail.com"}}
      post authentication_path, :params => {"username" => "test123", "password" => "pass123"}
    end

    it "edits a user's information through form fields" do
      post user_edit_path, :xhr => true, :params => {"user_form"=>{"first_name"=>"John", "last_name"=>"Smith",
        "email"=>"jsmith@hotmail.com", "address"=>"123 Leaf Street", "city"=>"Toronto",
        "province"=>"Ontario", "country"=>"Canada", "postal_code"=>"m1m1m1"}}

      expect(assigns(:user)).to have_attributes("first_name"=>"John", "last_name"=>"Smith",
        "email"=>"jsmith@hotmail.com")

      expect(assigns(:user).address).to have_attributes("address"=>"123 Leaf Street", "city"=>"Toronto",
        "province"=>"Ontario", "country"=>"Canada", "postal_code"=>"m1m1m1")
    end
  end
end
