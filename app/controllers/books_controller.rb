class BooksController < ApplicationController
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
      redirect_to book_path(@book)  # ここを修正
    else
      flash[:error] = 'error creating'
      render :new
    end
  end

def edit
  @book = Book.find(params[:id])
end

  def index
    @user = current_user
    @books = @user.books
    @books = Book.includes(:user).all
  end

  def show
    @user = current_user  # 現在のユーザーを設定
    @book = Book.find(params[:id])  # 本をIDで検索
    @books = @user.books  # 現在のユーザーの本を取得
  end

  def update
    @book = Book.find(params[:id])  # @bookを設定していないようなので追加
    if @book.update(book_params)    # @book.updateに修正
      flash[:notice] = 'successfully updated'
      redirect_to books_path
    else
      flash[:error] = 'error updating'
      render :edit  # :newから:editに修正
    end
  end

  def destroy
    @book = Book.find_by(id: params[:id])
    if @book
      if @book.destroy
        flash[:notice] = 'Successfully deleted'
        redirect_to books_path
      else
        flash[:error] = 'Error deleting'
        redirect_to book_path(@book)
      end
    else
      flash[:error] = 'Book not found'
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
