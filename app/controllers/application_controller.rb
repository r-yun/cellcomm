class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

def logged_in?
  if session[:username].blank?
    flash[:notice] = "Please login"
    redirect_to(login_page_path)
  end
end
end
