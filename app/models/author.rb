class Author < ApplicationRecord
  validates_presence_of :name

  has_many :book_authors
  has_many :books, through: :book_authors, dependent: :destroy

  has_many :reviews, through: :books
  has_many :users, through: :reveiws

  def only_author
    books.map do |book|
      if book.authors.count < 2
        book
      end
    end.compact
  end
end


#make column call author_count, then count the authors in the column
