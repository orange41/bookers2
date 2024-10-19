class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def new
    @book = Book.new
  end

  def after_sign_in_path_for(resource)
    books_path
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = 'successfully created'
      redirect_to book_path(@book)
    else
      flash[:error] = 'error creating'
      @user = current_user  # ここでログインユーザーを再設定
      @books = Book.all
      render 'index'
    end
  end

def edit
  @book = Book.find(params[:id])
end

  def index
    @user = current_user
    @books = @user.books
    @books = Book.includes(:user).all
    @book = Book.new  
  end

  def show
    @user = current_user  # 現在のユーザーを設定
    @book = Book.find(params[:id])  # 本をIDで検索
    @books = @user.books  # 現在のユーザーの本を取得
  end

  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
    flash[:notice] = 'successfully updated'
    redirect_to book_path(@book)
   else
    flash[:error] = 'error updating'
    render :edit
   end
  end

  def destroy
    @book = Book.find_by(id: params[:id])
    if @book
      if @book.destroy
        flash[:notice] = 'successfully deleted'
        redirect_to books_path
      else
        flash[:error] = 'error deleting'
        redirect_to book_path(@book)
      end
    else
      flash[:error] = 'book not found'
      redirect_to books_path
    end
  end

  private

  def correct_user
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user == current_user
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
