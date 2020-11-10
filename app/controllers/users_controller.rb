class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, except: %i(new create)
  before_action :correct_user, only: %i(edit update)
  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t "controller.user.show.warning"
    redirect_to login_path
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "controller.user.create.success"
      redirect_to root_path
    else
      flash[:warning] = t "controller.user.create.warning"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = t "users_control.update"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation, :phone)
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t "users_control.found"
    redirect_to signup_path
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end
end
