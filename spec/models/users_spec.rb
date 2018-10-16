require 'rails_helper'

describe User, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:name)}
  end

  describe 'Relationships' do
    it {should have_many(:reviews)}

  end

  describe 'Class Methods' do

    it '.top_three_reviewers' do
      user_1 = User.create(name: "Joey Fatone")
      user_2 = User.create(name: "Justin Timberlake")
      user_3 = User.create(name: "Lance Bass")
      user_4 = User.create(name: "Carl Malone")
      author_1 = Author.create(name: "Mary Sue")

      book_1 = author_1.books.create(title: "Joe, First", pages: 430, year: 1947)

      review_1 = book_1.reviews.create(title: "Joe First is Awful", description: "I hated this book so much...", score: 4, user: user_1)
      review_2 = book_1.reviews.create(title: "Joe First was pretty Bad", description: "This book was not as bad as I thought...", score: 5, user: user_1)
      review_3 = book_1.reviews.create(title: "Joe Second is Better", description: "This book wasn't the worst thing I've ever read...", score: 3, user: user_1)
      review_4 = book_1.reviews.create(title: "Joe Second was an Okay book", description: "This book was not as bad as I thought...", score: 4, user: user_1)

      review_5 = book_1.reviews.create(title: "Joe Third is Good", description: "This book was really good...", score: 3, user: user_2)
      review_6 = book_1.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_2)
      review_7 = book_1.reviews.create(title: "This book is awesome", description: "This is poorly written...", score: 1, user: user_2)

      review_8 = book_1.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_3)
      review_9 = book_1.reviews.create(title: "Joe Third is my new Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_3)

      review_10 = book_1.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_4)

      top_three_users = User.top_three_reviewers

      expect(top_three_users).to eq([user_1, user_2, user_3])
    end

  end
end
