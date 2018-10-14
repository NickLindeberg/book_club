class Author < ApplicationRecord
  validates_presence_of :name

  has_many :book_authors
  has_many :books, through: :book_authors, dependent: :destroy

  has_many :reviews, through: :books
  has_many :users, through: :reveiws
end
