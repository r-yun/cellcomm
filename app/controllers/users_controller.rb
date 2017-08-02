class UsersController < ApplicationController
  before_action :user

  def create
    #@new_user may not need to be an instance vr
    @new_user = User.new(new_user_params)
    if @new_user.save
      cart = Cart.create(:user => @new_user)
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
    @user_edit = UserEdit.new(@user)
    flash.now[:notice] = "Personal information saved." if @user_edit.assign_params(params) && @user_edit.submit
  end

  def user_page
    @user_edit = UserEdit.new(@user)
    @user = User.find(session[:user_id])
    @address =  @user.address || @user.build_address
  end

  private

  def new_user_params
    params.require(:user).permit(:username, :password, :first_name, :last_name,
      :email)
  end

  def updated_params
    params.require(:user_edit).permit(:first_name,
      :last_name, :email, :address, :city, :province,
      :country, :postal_code)
  end

end
