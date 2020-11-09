module SessionsHelper
  include ApplicationHelper
  def log_in user
    session[:user_id] = user.id
  end

  # Get valid user to check is logged_in ?
  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by id: user_id
      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Authentication user to perform functions of this user
  def current_user? user
    user == current_user
  end

  # Check user exist ?
  def logged_in?
    current_user.present?
  end
end
