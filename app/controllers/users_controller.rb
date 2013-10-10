class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new()
    @user.save
    flash[:notice] = "User #{@user.username} was succesfully created."
    redirect_to users_path
  end

  private

  def  params_user
    params.require(:user).permit(:username, :email, :firstname, :lastname)
  end
end
