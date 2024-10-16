class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "User successfully created"
      redirect_to user_path(@user) # 修正した部分
    else
      flash[:error] = "Error in registration"
      render 'new'
    end
  end

  def show
    @user = current_user
    @books = @user.books.page(params[:page])
  end

  def edit
    @user = current_user
    render 'edit'
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = "Successfully updated"
      redirect_to user_path(@user)
    else
      flash[:error] = "Error in updating profile"
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Successfully destroyed"
    redirect_to root_path
  end

  def login
    @user = User.find(params[:id]) # ログインするユーザーを取得するコードを追加
    session[:user_id] = @user.id
    flash[:success] = "Signed in successfully."
    redirect_to user_path(@user)
  end

  def logout
    session[:user_id] = nil # セッションを削除するコードを追加
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

  def index
    @users = User.all
  end

  private

def user_params
  params.require(:user).permit(:name, :email, :password, :introduction, :profile_image)
end

  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end