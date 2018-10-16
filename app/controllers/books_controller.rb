class BooksController < ApplicationController

  def index
    @books = Book.all

    @three_highest = Book.three_highest_rated_books
    @three_lowest = Book.three_lowest_rated_books

    @three_top_users = User.top_three_reviewers
  end

  def show
    @book = Book.find(params[:id])
    @reviews = Review.where("book_id = ?", params[:book_id])

    @highest_reviews = @book.highest_rated_reviews
    @lowest_reviews = @book.lowest_rated_reviews
    @average = @book.average_rating
  end

  def new
    @book = Book.new()
  end

  def create
    @authors = params[:author_names]
    @title = book_params[:title].titleize
    @book = Book.create(book_params)
    @book.title = @title

    if @book.save
      @authors.split(", ").each do |author_name|
        author_name.chomp
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
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :year)
  end

end
