class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You have successfully registered."
      #need to add to session[:username] so do not have to signi in again
      redirect_to(phones_path)
    else
      flash.now[:notice] = "You have not successfully registered."
      render("login/login_page")
    end
  end
  private
  def user_params
    params.require(:user).permit(:username,:password,:first_name,:last_name,
    :email)
  end
end
