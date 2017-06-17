class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def logged_in?
    if session[:username].blank?
      redirect_to(login_page_path)
    end
  end

  def user
    if session[:username]
      @user = User.find(session[:user_id])
    end
  end

end
