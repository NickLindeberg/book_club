class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @authors = Author.all
    @book = Book.new()
  end

  def create
    # require 'pry'; binding.pry
    @book = @author.books.create(book_params)
    @author = @book.authors
    if @book.save
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:success] = 'Book deleted'
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :year)
  end

end
