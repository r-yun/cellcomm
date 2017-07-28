require 'rails_helper'

RSpec.describe LoginController, type: :controller do

  describe "authentication (POST)" do
    before(:example) {
      @created_user = User.create("username" => "test123", "password" => "pass123",
        "first_name" => "John", "last_name" => "Smith", "email" => "jsmith@hotmail.com")
    }

    it "successfully authenticates the user" do
      controller.instance_variable_set(:@user, @created_user)
      post :authentication, :params => {"username" => "test123", "password" => "pass123"}
      expect(assigns(:authenticated_user)).to eq(assigns(:user))
    end

    it "successfully rejects failed login attempt" do
      post :authentication, :params => {"username" => "test123", "password" => "pass124"}
      expect(assigns(:authenticated_user)).to eq(false)
    end
  end
end
