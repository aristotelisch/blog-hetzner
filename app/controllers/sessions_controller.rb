class SessionsController < ApplicationController

  def new
    # renders new.html.erb in order to sign in with an email
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    cookies.signed[:user_id] = @user.id
    flash[:notice] = "Welcome #{@user.firstname}. You have signed in as #{@user.username} with email: #{@user.email}"
    redirect_to articles_path
  end

  def destroy
    if cookies[:user_id]
      cookies.delete(:user_id)
      flash[:notice] = "You have signed out." 
    end 
      redirect_to root_path
  end
end
