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
    redirect_to books_path
  else
    flash[:error] = 'error creating'
    render :new
  end
end

def index
  @user = current_user
  @books = Book.includes(:user).all
end

  def show
    @book = Book.find(params[:id])
  end

  def update
     if @book.save
    flash[:notice] = 'successfully updated'
    redirect_to books_path
  else
    flash[:error] = 'error  updating'
    render :new
  end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end