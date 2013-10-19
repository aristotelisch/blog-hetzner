class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private
  
  helper_method :current_user
  def current_user
    if cookies[:user_id]
     user_id = cookies.signed[:user_id]
     @current_user =  User.find_by_id(user_id)
    end
  end
  
  helper_method :signed_in?  
  def signed_in?
    current_user
  end

  def authenticate
    if !signed_in?
      flash[:warning] = "Please sign in."
      redirect_to new_session_path 
    end
  end
end
