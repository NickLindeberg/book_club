require 'rails_helper'

describe Book, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:pages)}
    it {should validate_presence_of(:year)}
  end

  describe 'Relationship' do
    it {should have_many(:book_authors)}
    it {should have_many(:authors).through(:book_authors)}
    it {should have_many(:reviews)}
  end

  describe 'Class Methods' do
    # xit '.average_rating_asc' do
    #   user_1 = User.create(name: "Joey Fatone")
    #   author_1 = Author.create(name: "Mary Sue")
    #
    #   book_1 = author_1.books.create(title: "Joe, First", pages: 430, year: 1947)
    #   review_1 = book_1.reviews.create(title: "Joe First is Awful", description: "I hated this book so much...", score: 1, user: user_1)
    #   review_2 = book_1.reviews.create(title: "Joe First was pretty Bad", description: "This book was not as bad as I thought...", score: 2, user: user_1)
    #
    #   book_2 = author_1.books.create(title: "Joe, Second", pages: 430, year: 1947)
    #   review_3 = book_2.reviews.create(title: "Joe Second is Better", description: "This book wasn't the worst thing I've ever read...", score: 3, user: user_1)
    #   review_4 = book_2.reviews.create(title: "Joe Second was an Okay book", description: "This book was not as bad as I thought...", score: 4, user: user_1)
    #
    #   book_3 = author_1.books.create(title: "Joe, Finale", pages: 430, year: 1947)
    #   review_5 = book_3.reviews.create(title: "Joe Third is Good", description: "This book was really good...", score: 4, user: user_1)
    #   review_6 = book_3.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_1)
    #   sorted_books = Book.average_rating_asc
    #
    #   expect(sorted_books).to eq([book_1, book_2, book_3])
    # end


    it '.num_pages_DESC' do
      author_1 = Author.create(name: "Mary Sue")
      book_1 = author_1.books.create(title: "Joe, I", pages: 430, year: 1947)
      book_2 = author_1.books.create(title: "Joe, II", pages: 450, year: 1948)
      book_3 = author_1.books.create(title: "Joe, III", pages: 500, year: 1949)
      book_4 = author_1.books.create(title: "Joe, IV", pages: 600, year: 1950)

      highest_pages = Book.num_pages_DESC
      expect(highest_pages).to eq([book_4, book_3, book_2, book_1])
    end

    it '.num_pages_ASC' do
      author_1 = Author.create(name: "Mary Sue")
      book_1 = author_1.books.create(title: "Joe, I", pages: 430, year: 1947)
      book_2 = author_1.books.create(title: "Joe, II", pages: 450, year: 1948)
      book_3 = author_1.books.create(title: "Joe, III", pages: 500, year: 1949)
      book_4 = author_1.books.create(title: "Joe, IV", pages: 600, year: 1950)

      fewest_pages = Book.num_pages_ASC
      expect(fewest_pages).to eq([book_1, book_2, book_3, book_4])
    end




    it '.three_highest_rated_books' do
      user_1 = User.create(name: "Joey Fatone")
      author_1 = Author.create(name: "Mary Sue")

      book_1 = author_1.books.create(title: "Joe, First", pages: 430, year: 1947)
      review_1 = book_1.reviews.create(title: "Joe First is Awful", description: "I hated this book so much...", score: 4, user: user_1)
      review_2 = book_1.reviews.create(title: "Joe First was pretty Bad", description: "This book was not as bad as I thought...", score: 5, user: user_1)

      book_2 = author_1.books.create(title: "Joe, Second", pages: 430, year: 1947)
      review_3 = book_2.reviews.create(title: "Joe Second is Better", description: "This book wasn't the worst thing I've ever read...", score: 3, user: user_1)
      review_4 = book_2.reviews.create(title: "Joe Second was an Okay book", description: "This book was not as bad as I thought...", score: 4, user: user_1)

      book_3 = author_1.books.create(title: "Joe, Finale", pages: 430, year: 1947)
      review_5 = book_3.reviews.create(title: "Joe Third is Good", description: "This book was really good...", score: 3, user: user_1)
      review_6 = book_3.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_1)

      book_4 = author_1.books.create(title: "Joe, Ultima", pages: 430, year: 1947)
      review_7 = book_4.reviews.create(title: "This book is awesome", description: "This is poorly written...", score: 1, user: user_1)
      review_8 = book_4.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_1)

      highest_three_books = Book.three_highest_rated_books

      expect(highest_three_books).to eq([book_1, book_3, book_2])

    end

    it '.three_lowest_rated_books' do
      user_1 = User.create(name: "Joey Fatone")
      author_1 = Author.create(name: "Mary Sue")

      book_1 = author_1.books.create(title: "Joe, First", pages: 430, year: 1947)
      review_1 = book_1.reviews.create(title: "Joe First is Awful", description: "I hated this book so much...", score: 4, user: user_1)
      review_2 = book_1.reviews.create(title: "Joe First was pretty Bad", description: "This book was not as bad as I thought...", score: 5, user: user_1)

      book_2 = author_1.books.create(title: "Joe, Second", pages: 430, year: 1947)
      review_3 = book_2.reviews.create(title: "Joe Second is Better", description: "This book wasn't the worst thing I've ever read...", score: 3, user: user_1)
      review_4 = book_2.reviews.create(title: "Joe Second was an Okay book", description: "This book was not as bad as I thought...", score: 4, user: user_1)

      book_3 = author_1.books.create(title: "Joe, Finale", pages: 430, year: 1947)
      review_5 = book_3.reviews.create(title: "Joe Third is Good", description: "This book was really good...", score: 3, user: user_1)
      review_6 = book_3.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_1)

      book_4 = author_1.books.create(title: "Joe, Ultima", pages: 430, year: 1947)
      review_7 = book_4.reviews.create(title: "This book is awesome", description: "This is poorly written...", score: 1, user: user_1)
      review_8 = book_4.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_1)

      highest_three_books = Book.three_lowest_rated_books

      expect(highest_three_books).to eq([book_4, book_2, book_3])

    end

    it '.most_reviews' do
      user_1 = User.create(name: "Joey Fatone")
      author_1 = Author.create(name: "Mary Sue")

      book_1 = author_1.books.create(title: "Joe, I", pages: 430, year: 1947)
      book_2 = author_1.books.create(title: "Joe, II", pages: 430, year: 1947)
      book_3 = author_1.books.create(title: "Joe, III", pages: 430, year: 1947)

      review_1 = book_3.reviews.create(title: "Joe First is Awful", description: "I hated this book so much...", score: 4, user: user_1)
      review_2 = book_3.reviews.create(title: "Joe First was pretty Bad", description: "This book was not as bad as I thought...", score: 5, user: user_1)
      review_3 = book_3.reviews.create(title: "Joe Second is Better", description: "This book wasn't the worst thing I've ever read...", score: 3, user: user_1)

      review_4 = book_2.reviews.create(title: "Joe Second was an Okay book", description: "This book was not as bad as I thought...", score: 4, user: user_1)
      review_5 = book_2.reviews.create(title: "Joe Third is Good", description: "This book was really good...", score: 3, user: user_1)

      review_6 = book_1.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_1)

      most_reviews = Book.most_reviews

      expect(most_reviews).to eq([book_3, book_2, book_1])
    end

    it '.fewest_reviews' do
      user_1 = User.create(name: "Joey Fatone")
      author_1 = Author.create(name: "Mary Sue")

      book_1 = author_1.books.create(title: "Joe, I", pages: 430, year: 1947)
      book_2 = author_1.books.create(title: "Joe, II", pages: 430, year: 1947)
      book_3 = author_1.books.create(title: "Joe, III", pages: 430, year: 1947)

      review_1 = book_3.reviews.create(title: "Joe First is Awful", description: "I hated this book so much...", score: 4, user: user_1)
      review_2 = book_3.reviews.create(title: "Joe First was pretty Bad", description: "This book was not as bad as I thought...", score: 5, user: user_1)
      review_3 = book_3.reviews.create(title: "Joe Second is Better", description: "This book wasn't the worst thing I've ever read...", score: 3, user: user_1)

      review_4 = book_2.reviews.create(title: "Joe Second was an Okay book", description: "This book was not as bad as I thought...", score: 4, user: user_1)
      review_5 = book_2.reviews.create(title: "Joe Third is Good", description: "This book was really good...", score: 3, user: user_1)

      review_6 = book_1.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_1)

      fewest_reviews = Book.fewest_reviews

      expect(fewest_reviews).to eq([book_1, book_2, book_3])
    end

    it '.highest_average_rating' do
      user_1 = User.create(name: "Joey Fatone")
      author_1 = Author.create(name: "Mary Sue")

      book_1 = author_1.books.create(title: "Joe, I", pages: 430, year: 1947)
      book_2 = author_1.books.create(title: "Joe, II", pages: 430, year: 1947)
      book_3 = author_1.books.create(title: "Joe, III", pages: 430, year: 1947)

      review_1 = book_3.reviews.create(title: "Joe First is Awful", description: "I hated this book so much...", score: 3, user: user_1)
      review_2 = book_3.reviews.create(title: "Joe First was pretty Bad", description: "This book was not as bad as I thought...", score: 2, user: user_1)

      review_3 = book_2.reviews.create(title: "Joe Second is Better", description: "This book wasn't the worst thing I've ever read...", score: 3, user: user_1)
      review_4 = book_2.reviews.create(title: "Joe Second was an Okay book", description: "This book was not as bad as I thought...", score: 4, user: user_1)

      review_5 = book_1.reviews.create(title: "Joe Third is Good", description: "This book was really good...", score: 4, user: user_1)
      review_6 = book_1.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_1)

      highest_rated = Book.highest_rated

      expect(highest_rated).to eq([book_1, book_2, book_3])
    end

    it '.lowest_average_rating' do
      user_1 = User.create(name: "Joey Fatone")
      author_1 = Author.create(name: "Mary Sue")

      book_1 = author_1.books.create(title: "Joe, I", pages: 430, year: 1947)
      book_2 = author_1.books.create(title: "Joe, II", pages: 430, year: 1947)
      book_3 = author_1.books.create(title: "Joe, III", pages: 430, year: 1947)

      review_1 = book_3.reviews.create(title: "Joe First is Awful", description: "I hated this book so much...", score: 3, user: user_1)
      review_2 = book_3.reviews.create(title: "Joe First was pretty Bad", description: "This book was not as bad as I thought...", score: 2, user: user_1)

      review_3 = book_2.reviews.create(title: "Joe Second is Better", description: "This book wasn't the worst thing I've ever read...", score: 3, user: user_1)
      review_4 = book_2.reviews.create(title: "Joe Second was an Okay book", description: "This book was not as bad as I thought...", score: 4, user: user_1)

      review_5 = book_1.reviews.create(title: "Joe Third is Good", description: "This book was really good...", score: 4, user: user_1)
      review_6 = book_1.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_1)

      lowest_rated = Book.lowest_rated

      expect(lowest_rated).to eq([book_3, book_2, book_1])
    end
  end

  describe 'Instance Methods' do
    it '.lowest_rated_reviews' do
      user_1 = User.create(name: "Joey Fatone")
      author_1 = Author.create(name: "Mary Sue")

      book_1 = author_1.books.create(title: "Joe, First", pages: 430, year: 1947)
      review_1 = book_1.reviews.create(title: "Joe First is Awful", description: "I hated this book so much...", score: 2, user: user_1)
      review_2 = book_1.reviews.create(title: "Joe First was pretty Bad", description: "This book was not as bad as I thought...", score: 1, user: user_1)
      review_3 = book_1.reviews.create(title: "Joe Second is Better", description: "This book wasn't the worst thing I've ever read...", score: 3, user: user_1)
      review_4 = book_1.reviews.create(title: "Joe Second was an Okay book", description: "This book was not as bad as I thought...", score: 4, user: user_1)

      lowest_rated = book_1.lowest_rated_reviews

      expect(lowest_rated).to eq([review_2, review_1, review_3])
    end

    it '.highest_rated_reviews' do
      user_1 = User.create(name: "Joey Fatone")
      author_1 = Author.create(name: "Mary Sue")

      book_1 = author_1.books.create(title: "Joe, First", pages: 430, year: 1947)
      review_1 = book_1.reviews.create(title: "Joe First is Awful", description: "I hated this book so much...", score: 2, user: user_1)
      review_2 = book_1.reviews.create(title: "Joe First was pretty Bad", description: "This book was not as bad as I thought...", score: 1, user: user_1)
      review_3 = book_1.reviews.create(title: "Joe Second is Better", description: "This book wasn't the worst thing I've ever read...", score: 3, user: user_1)
      review_4 = book_1.reviews.create(title: "Joe Second was an Okay book", description: "This book was not as bad as I thought...", score: 4, user: user_1)

      highest_rated = book_1.highest_rated_reviews

      expect(highest_rated).to eq([review_4, review_3, review_1])
    end

  end

end
