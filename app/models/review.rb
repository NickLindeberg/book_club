class Review < ApplicationRecord
  validates_presence_of :title, :description, :score

  belongs_to :user
  belongs_to :book

  has_many :authors, through: :book

  def self.total_reviews
    Review.count
  end

  def self.avg_score
    @avg = average(:score)
  end

  def self.oldest
    Review.order("created_at DESC")
  end

  def self.newest
    Review.order("created_at ASC")
  end

end
