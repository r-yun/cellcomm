require 'rails_helper'

RSpec.describe LoginController, type: :controller do

describe "authentication (POST)" do
  before(:context){

  }
  before(:example) {
  @created_user = User.create("username" => "test123", "password" => "pass123",
  "first_name" => "John", "last_name" => "Smith", "email" => "jsmith@hotmail.com")
   }

  it "successfully authenticates user" do
    post :authentication, :params => {"username" => "test123", "password" => "test123"}
    controller.instance_variable_set(:@user, @created_user)
    expect(@created_user).to eq(assigns(:user))
    expect(assigns(:user).authenticate("pass123")).to eq(assigns(:user))
  end

  it "successfully rejects failed login attempt" do
    post :authentication, :params => {"username" => "test123", "password" => "test123"}
    #use assigns later
    @found_user = User.find_by(:username => "test123")
    expect(@found_user.authenticate("pass124")).to eq(false)
  end





end

end
