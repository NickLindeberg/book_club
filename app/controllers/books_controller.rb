class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new()
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:success] = 'Book deleted'
    redirect_to books_path
  end

end
