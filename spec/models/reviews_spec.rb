require 'rails_helper'


describe Review, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:score)}
  end

  describe 'Relationship' do 
    it {should belong_to(:user)}
    it {should belong_to(:book)}
  end

  describe 'Class Methods' do
    it '.total_reviews' do 
      author_1 = Author.create(name: "Mary Sue")
      book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
      user_1 = User.create(name: "Joey Fatone")
      review_1 = book_1.reviews.create(title: "Sharks are fun", description: "Who doesn't love a good shark...?", score: 5, user: user_1)
      review_2 = book_1.reviews.create(title: "Sharks are awful", description: "Only evil people love sharks...?", score: 1, user: user_1)
      
      expect(Review.total_reviews).to eq(2)
    end 

    it '.avg_score' do
      author_1 = Author.create(name: "Mary Sue")
      book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
      user_1 = User.create(name: "Joey Fatone")
      review_1 = book_1.reviews.create(title: "Sharks are fun", description: "Who doesn't love a good shark...?", score: 5, user: user_1)
      review_2 = book_1.reviews.create(title: "Sharks are awful", description: "Only evil people love sharks...?", score: 1, user: user_1)
      
      expect(Review.avg_score).to eq(3)
    end

    it '.newest' do
      author_1 = Author.create(name: "Mary Sue")
      book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
      user_1 = User.create(name: "Joey Fatone")
      review_1 = book_1.reviews.create(title: "Sharks are fun", description: "Who doesn't love a good shark...?", score: 5, user: user_1)
      review_1.created_at = Time.parse("2012-07-11")
      review_2 = book_1.reviews.create(title: "Sharks are awful", description: "Only evil people love sharks...?", score: 1, user: user_1)
      review_2.created_at = Time.parse("2012-08-11")
      
      newest_first = Review.newest

      expect(newest_first).to eq([review_2, review_1])
    end

    it '.oldest' do
      author_1 = Author.create(name: "Mary Sue")
      book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
      user_1 = User.create(name: "Joey Fatone")
      review_1 = book_1.reviews.create(title: "Sharks are fun", description: "Who doesn't love a good shark...?", score: 5, user: user_1)
      review_1.created_at = Time.parse("2012-07-11")
      review_2 = book_1.reviews.create(title: "Sharks are awful", description: "Only evil people love sharks...?", score: 1, user: user_1)
      review_2.created_at = Time.parse("2012-08-11")
      
      oldest_first = Review.oldest

      expect(oldest_first).to eq([review_1, review_2])
    end

  end

end
