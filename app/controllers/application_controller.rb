class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # määritellään, että metodi current_user tulee käyttöön myös näkymissä

  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice: 'You should be signed in' if current_user.nil?
  end

  def ensure_that_is_admin
    redirect_to :back, notice: 'This action is only allowed for admins' unless current_user.admin
  end

  def if_user_has_banned
   unless current_user.nil?
     if current_user.banned
      session[:user_id] = nil
      redirect_to :back, notice: 'Your account is frozen, please contact admin'
     end
   end
  end
end
