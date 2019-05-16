class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    user ||= User.find_by(session_token: self.session[:session_token])
    user
  end

  def login_user!(user)
    current_session_token = user.reset_session_token!
    self.session[:session_token] = current_session_token
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user_or_redirect
    if current_user.nil?
      flash[:errors] = "You must be logged in to access that page"
      redirect_to new_session_url
    end
  end
end
