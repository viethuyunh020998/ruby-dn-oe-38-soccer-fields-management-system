class AdminController < ApplicationController
  before_action :fake_user
  before_action :check_login
  before_action :check_admin

  private

  def check_login
    return if logged_in?

    flash[:warning] = t "message.pls_login"
    redirect_to login_path
  end

  def check_admin
    return if current_admin?

    flash[:warning] = t "message.is_admin"
    redirect_to root_path
  end

  # Use to fake user is admin
  def fake_user
    session[:user_id] = User.first.id
  end
end
