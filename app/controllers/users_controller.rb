class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect user_path()
  end


end
