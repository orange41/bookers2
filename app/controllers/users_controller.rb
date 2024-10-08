class UsersController < ApplicationController
def show
  @user = User.find(params[:id])
  @books = @user.books.all.page(params[:page])
end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def authenticate_user
    unless logged_in?
      flash[:alert] = "ログインが必要です"
      redirect_to login_path
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
