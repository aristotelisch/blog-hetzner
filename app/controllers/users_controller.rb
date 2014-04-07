class UsersController < ApplicationController
  before_filter :authenticate

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params_user)
    if @user.save
      flash[:notice] = "User #{@user.username} was succesfully created."
      redirect_to root_path
    else
      redirect_to new_user_path, notice: "User was not created"
    end
  end

  private

  def  params_user
    params.require(:user).permit(:username, :email, :firstname, :lastname, :password, :password_confirmation)
  end
end
