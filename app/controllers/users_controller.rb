class UsersController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account created successfully! Welcome to MessageMe, #{@user.username}!"
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def logged_in_redirect
    if logged_in?
      redirect_to root_path, alert: "You are already logged in."
    end
  end
end
