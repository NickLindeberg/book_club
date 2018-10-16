class User < ApplicationRecord
  validates_presence_of :name

  has_many :reviews
  has_many :books, through: :reviews
  has_many :authors, through: :books


  def self.top_three_reviewers
    select('users.*, COUNT(score) AS user_reviews')
    .joins(:reviews)
    .group(:id)
    .order('user_reviews DESC')
    .limit(3)
  end
end
