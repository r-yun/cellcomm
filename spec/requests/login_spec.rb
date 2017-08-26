require 'rails_helper'

RSpec.describe "Login", type: :request do
  describe "authentication (POST)" do
    before(:example) do
      post users_path, :params => {"user"=>{"username"=>"test123", "password"=>"pass123",
        "first_name" => "John", "last_name" => "Smith", "email" => "jsmith@hotmail.com"}}
    end

    it "successfully authenticates the user" do
      post authentication_path, :params => {"username" => "test123", "password" => "pass123"}
      expect(assigns(:authenticated_user)).to have_attributes("username"=>"test123",
      "first_name"=>"John", "last_name"=>"Smith", "email"=>"jsmith@hotmail.com")
    end

    it "successfully rejects failed login attempt" do
      post authentication_path, :params => {"username" => "test123", "password" => "pass124"}
      expect(assigns(:authenticated_user)).to eq(false)
    end
  end
end
