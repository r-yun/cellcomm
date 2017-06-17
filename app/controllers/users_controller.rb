class UsersController < ApplicationController
  before_action :user

  def new
    @new_user = User.new
  end

  def user_edit
    @user = User.find(session[:user_id])
    @user.skip_user_validation = true
    @user.skip_password_validation = true
    if @user.update_attributes(updated_params)
      flash.now[:notice] = "Personal information saved"
    end
  end

  def user_page
    @user = User.find(session[:user_id])
    @address =  @user.address || @user.build_address
  end


  def create
    @new_user = User.new(new_user_params)
    if @new_user.save
      flash[:notice] = "You have successfully registered."
      @cart = Cart.create
      @address = Address.new
      @address.save(:validate => false)
      #cart_id.save in cart.create
      @new_user.update_attributes(:cart_id => @cart.id, :address_id => @address.id)

      #need to add to session[:username] so do not have to signi in again
      redirect_to(phones_path)
    else
      flash.now[:notice] = "You have not successfully registered."
      render("new")
    end
  end

  private

  def new_user_params
    params.require(:user).permit(:username, :password, :first_name, :last_name,
    :email)
  end

  def updated_params
    params.require(:user).permit(:first_name,
    :last_name, :email, :address_attributes => [:address, :city, :province, :country, :postal_code])
  end

end
