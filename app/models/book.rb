class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :pages
  validates_presence_of :year

  has_many :book_authors
  has_many :authors, through: :book_authors, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def self.average_rating_asc
    Book.joins(:reviews).merge(Review.score, priority: :desc)
    # Reviews.order(score: :asc)
  end
end
