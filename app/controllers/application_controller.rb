class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :admin?
  protect_from_forgery with: :exception

  protected
  # def is_admin?
  #   if @current_user.admin == 'true'
  #   end
  # end

  def admin?
    if current_user.admin == true
     true
    else
    false
  end
  end

  # def restrict_access
  #   if !current_user
  #     flash[:alert] = "You must log in."
  #     redirect_to new_session_path
  #   end
  # end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user




def authorize
  unless admin?
    flash[:error] = "unauthorized access"
    redirect_to movies_path
    false
  end
end

end

