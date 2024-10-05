class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  
def after_sign_in_path_for(resource)
    books_path
end

  # 投稿データの保存
def create
  @book = Book.new(book_params)
  @book.user_id = current_user.id
  if @book.save
    redirect_to books_path, notice: '書籍が正常に作成されました。'
  else
    render :new
  end
end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:title, :body,)
  end
end