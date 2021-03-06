class ReviewsController < ApplicationController

  def index
    @reviews = Review.where("user_id = ?", params[:user_id])
    if params[:sort] == "newest"
      @reviews = @reviews.newest
    elsif params[:sort] == "oldest"
      @reviews = @reviews.oldest
    end
  end

  def new
    @review = Review.new()
    @book = Book.find(params[:book_id])
  end

  def create
    @book = Book.find(params[:review][:book_id])
    @review = Review.create(review_params)
    @user = User.find_or_create_by(name: params[:user_name].titleize)
    @review.book_id = @book.id
    @review.user_id = @user.id
    
    if @review.save
      redirect_to book_path(@review.book)
    else
      render :new
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to user_reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:title, :score, :description, :user_id, :book_id)
  end

end
