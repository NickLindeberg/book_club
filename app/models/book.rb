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
end
