class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    redirect_to(login_page_path) if session[:username].blank?
  end

  def user
    @user = User.find(session[:user_id]) if session[:username]
  end

end
