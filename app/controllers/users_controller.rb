class UsersController < ApplicationController
before_action :authenticate_user, only: [:edit, :update]

before_action :authenticate_user!, except: [:index, :show]
end

class BooksController < ApplicationController
before_action :authenticate_user!
end

def new
@user = User.new
end

def create
@user = User.new(user_params)
if @user.save
flash[:success] = "successfully Login"
redirect_to login_path
else
flash[:error] = "Error in registration"
render 'new'
end
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
flash[:success] = "successfully Login"
end

def logout
flash[:success] = "successfully Logout"
end

def index
@users = User.all
end


private

def user_params
params.require(:user).permit(:name, :email, :password)
end

def authenticate_user
unless logged_in?
flash[:alert] = "Login is required"
redirect_to login_path
end
end

def logged_in?
!!current_user
end

def current_user
@current_user ||= User.find(session[:user_id]) if session[:user_id]
end