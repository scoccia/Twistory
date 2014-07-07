class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_permission_level
    
  def check_permission_level
    if user_signed_in? 
      permission = User.where(id: current_user.id).take
      if permission.permission_level != 0
        sign_out 
        redirect_to "http://localhost:3000/acces_denied.html" # in public folder 
      end
    end 
  end
end
