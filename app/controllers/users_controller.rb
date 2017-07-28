class UsersController < ApplicationController
  before_action :user

  def create
    @new_user = User.new(new_user_params)
    if @new_user.save
      @cart = Cart.create
      @new_user.update_attributes(:cart => @cart, :address => @address)
      link = view_context.link_to("here.", login_page_path, :class => 'here')
      flash[:notice] = "You have successfully registered. Please login #{link}".html_safe
      redirect_to(phones_path)
    else
      flash.now[:notice] = "You have not successfully registered."
      render("new")
    end
  end

  def new
    @new_user = User.new
  end

  def user_edit
    @user = User.find(session[:user_id])
    @user.skip_user_validation = true
    @user.skip_password_validation = true
    if @user.update_attributes(updated_params)
      flash.now[:notice] = "Personal information saved."
    end
  end

  def user_page
    @user = User.find(session[:user_id])
    @address =  @user.address || @user.create_address
  end

  private

  def new_user_params
    params.require(:user).permit(:username, :password, :first_name, :last_name,
    :email)
  end

  def updated_params
    params.require(:user).permit(:first_name,
      :last_name, :email, :address_attributes => [:address, :city, :province,
      :country, :postal_code])
  end

end
