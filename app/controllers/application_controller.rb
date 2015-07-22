class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?


  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :error => "Accès refussè."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :notice => 'Vous avez besoin de se connecter pour accèder à cette page.'
      end
    end


    def authorize_admin!
      authenticate_user!
      unless current_user.uid == Application.find(:uid_admin)
        redirect_to root_path, :error => "Vous devez être connecté en tant qu'administrateur pour cet opération"
      end
    end

end
