class LoginController < ApplicationController
  def login_page

  end

  def authentication
    if params[:username].present? && params[:password].present?
      user = User.find_by(:username => params[:username])
      if user
         authenticated_user = user.authenticate(params[:password])
    end
  end

    if authenticated_user
      session[:user_id] = user.id
      session[:username] = user.username
      flash[:notice] = "You have successfully logged in as #{user.username}"
      redirect_to(phones_path)
    else
      flash[:notice] = "Invalid username/password combination."
       redirect_to(login_page_path)
      end


        # if authenticated_user
        #
        # set session user id to user id and session username to user name
        # flash notice you are logged in
        # redirect to

      # else
      #   flash.now invalid user combination
      #   render login page

  end

def logout
  session[:user_id] = nil
  session[:username] = nil
  flash[:notice] = "You have been successfully logged out"
  redirect_to(phones_path)
end
  def register
  end
end
