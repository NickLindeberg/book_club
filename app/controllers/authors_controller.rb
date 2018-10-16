class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
  end

  def destroy
    author = Author.find(params[:id])
    books = author.only_author
    books.each do |b|
      b.destroy
    end
    author.destroy
    redirect_to books_path
  end
end
