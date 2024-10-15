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
  @user = User.find(params[:id])
  @books = @user.books.page(params[:page])
end

def edit
  @user = current_user
end

def update
@user = User.find(params[:id])
if @user.update(user_params)
flash[:success] = "successfully update"
redirect_to user_path(@user)
else
flash[:error] = "Error in updating profile"
render 'edit'
end
end

def destroy
@user = User.find(params[:id])
@user.destroy
flash[:success] = "successfully destroy"
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
params.require(:user).permit(:name, :email, :password)
end
end