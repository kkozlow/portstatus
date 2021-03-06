class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  helper_method :is_hebiznes
  
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def is_admin(user)
    if
      user.username == 'admin'
      return true
    elsif
      user.username == 'admin2'
      return true
    else
      return false
    end
  end
  
  def is_hebiznes(user)
    user.username == 'hebiznes'
  end
  
  def deny_hebiznes
    if (current_user.username != 'hebiznes')
      return true
    else
      redirect_to head_ends_path
      flash[:error] = 'Brak uprawnien dla tej sekcji'
      return false
    end
  end

  def require_user
      unless current_user
        flash[:alert] = 'Musisz byc zalogowany'
        redirect_to new_user_session_url
        return false
      end
  end

  def require_no_user
    if current_user
      flash[:error] = 'Musisz byc wylogowany'
      return false
    end
  end
    
  def verify_admin
    if (current_user.username == 'admin')
      return true
    elsif
       (current_user.username == 'admin2')
      return true
    else
      redirect_to login_path
      flash[:error] = 'Brak uprawnien dla tej sekcji'
      return false
    end
  end
  
  
   #def store_location
   #   session[:return_to] = request.request_uri
   #end
    
   #def redirect_back_or_default(default)
   #   redirect_to(session[:return_to] || default)
   #   session[:return_to] = nil
   #end
end
