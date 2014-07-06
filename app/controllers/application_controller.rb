class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :check_permission_level 
  
  def check_permission_level
    if user_signed_in? 
      permission = User.where(id: current_user.id).take
      if permission.permission_level == 100 
        flash.now[:notice] = "Attenzione! Non hai tutti i permessi per agire su questo sito" 
      end
    end 
  end

	helper_method :admin?
	
	protected

	def authorize
	permission = User.where(id: current_user.id).take
	 unless admin? and permission.permission_level == 0  
	    flash.now[:notice] = "Accesso non autorizzato"
	    redirect_to "http://localhost:3000"
	  false
	 end
	end
	
	def admin?
	permission = User.where(id: current_user.id).take
	  if permission.permission_level == 0
	true
	  end
	end

end
