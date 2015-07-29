class Admin::UsersController < ApplicationController
  before_filter :authorize
  def index
    @users = User.page(params[:page]).per(1)

  end


end
