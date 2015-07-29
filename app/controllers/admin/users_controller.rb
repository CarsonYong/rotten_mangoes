class Admin::UsersController < ApplicationController
  before_filter :authorize
  def index
    @users = User.page(params[:page]).per(11)

  end

  def new
    @user = User.new
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    if @user.destroy
      redirect_to admin_users_path
    else
      redirect_to movies_path
    end
  end

def create
    @user = User.new user_params
    #@user.admin = true
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end



end
