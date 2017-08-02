class LoginController < ApplicationController
  before_action :user, :except => :authentication
  def authentication
    user = User.find_by(:username => params[:username]) if params[:username].present? && params[:password].present?
    authenticated_user = user.authenticate(params[:password]) if user

    if authenticated_user
      session[:user_id] = user.id
      session[:username] = user.username
      flash[:notice] = "You have successfully logged in as #{user.username}."
      redirect_to(phones_path)
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to(login_page_path)
    end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:notice] = "You have been successfully logged out."
    redirect_to(phones_path)
  end

end
