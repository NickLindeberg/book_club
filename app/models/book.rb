class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :pages
  validates_presence_of :year

  has_many :book_authors
  has_many :authors, through: :book_authors, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :users, through: :reviews


  def self.three_highest_rated_books
    Book.select('books.*, avg(score) as avg_score')
    .joins(:reviews)
    .group(:book_id, :id)
    .order("avg_score DESC")
    .first(3)
  end

  def self.three_lowest_rated_books
    Book.select('books.*, avg(score) as avg_score')
    .joins(:reviews)
    .group(:book_id, :id)
    .order("avg_score ASC")
    .first(3)
  end


  def self.num_pages_DESC
    Book.order('pages DESC')
  end

  def self.num_pages_ASC
    Book.order('pages ASC')
  end

  def self.most_reviews
    Book.select('books.*, count(reviews) as review_count')
    .left_outer_joins(:reviews)
    .group(:book_id, :id)
    .order("review_count DESC")
  end

  def self.fewest_reviews
    Book.select('books.*, count(reviews) as review_count')
    .left_outer_joins(:reviews)
    .group(:book_id, :id)
    .order("review_count ASC")
  end

  def self.highest_rated
    Book.select('books.*, avg(score) as avg_score')
    .left_outer_joins(:reviews)
    .group(:book_id, :id)
    .order('avg_score DESC')
  end

  def self.lowest_rated
    Book.select('books.*, avg(score) as avg_score')
    .left_outer_joins(:reviews)
    .group(:book_id, :id)
    .order('avg_score ASC')
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
