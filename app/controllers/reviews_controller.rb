class ReviewsController < ApplicationController

  def destroy
    binding.pry
    @user = User.find(params[:id])
    review = Review.find(@user.id)
    
    review.destroy
    redirect_to user_path(@user)
  end


end