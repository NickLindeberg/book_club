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

  def create
    @authors = params[:author_names]
    @book = Book.create(book_params)

    if @book.save
      @authors.split(",").each do |author_name|
        author_name.chomp.titleize
        author = Author.find_or_create_by(name: author_name)
        BookAuthor.create(book: @book, author: author)
      end

      redirect_to book_path(@book)
    else
      redirect_to new_book_path
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
