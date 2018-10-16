class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :pages
  validates_presence_of :year

  has_many :book_authors
  has_many :authors, through: :book_authors, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :users, through: :reviews

  def self.average_rating_asc
  end

  def lowest_rated_reviews
    reviews.order(:score).limit(3)
  end

  def highest_rated_reviews 
    reviews.order("score DESC").limit(3)
  end 

  def average_rating
    reviews.average(:score)
  end 
end
