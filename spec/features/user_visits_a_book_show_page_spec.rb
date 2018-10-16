require 'rails_helper'

describe 'User visits book show' do
  it 'shows single book attributes' do
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
    book_2 = author_1.books.create(title: "Sharks", pages: 200, year: 1965)

    visit book_path(book_1)

    expect(page).to have_content(book_1.title)
    expect(page).to have_content(book_1.pages)
    expect(page).to have_content(book_1.year)
    expect(page).to_not have_content(book_2.title)
  end

  it 'show the reviews for a single book' do
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
    user_1 = User.create(name: "Joey Fatone")
    user_2 = User.create(name: "Chris Farley")
    review_1 = book_1.reviews.create(title: "Sharks are fun", description: "Who doesn't love a good shark...?", score: 5, user: user_1)
    review_2 = book_1.reviews.create(title: "Sharks are awful", description: "Only evil people love sharks...?", score: 1, user: user_2)

    visit book_path(book_1)

    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_1.description)
    expect(page).to have_content(review_1.score)
    expect(page).to have_content(user_1.name)

    expect(page).to have_content(review_2.title)
    expect(page).to have_content(review_2.description)
    expect(page).to have_content(review_2.score)
    expect(page).to have_content(user_2.name)

  end


  it 'allows user to delete book' do
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
    user_1 = User.create(name: "Joey Fatone")
    review_1 = book_1.reviews.create(title: "Sharks are fun", description: "Who doesn't love a good shark...?", score: 5, user: user_1)
    review_2 = book_1.reviews.create(title: "Sharks are awful", description: "Only evil people love sharks...?", score: 1, user: user_1)

    visit book_path(book_1)

    expect(page).to have_content(review_1.title)
    click_link "Delete"
    expect(current_path).to eq(books_path)

  end

  it 'user clicks home link' do
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)

    visit book_path(book_1)
    click_link "All Books"

    expect(current_path).to eq(books_path)
  end

  it 'displays highest scored reviews of the book' do
    user_1 = User.create(name: "Joey Fatone")
    author_1 = Author.create(name: "Mary Sue")

    book_1 = author_1.books.create(title: "Joe, First", pages: 430, year: 1947)

    review_1 = book_1.reviews.create(title: "Joe First is Awful", description: "I hated this book so much...", score: 1, user: user_1)
    review_2 = book_1.reviews.create(title: "Joe First was pretty Bad", description: "This book was not as bad as I thought...", score: 3, user: user_1)
    review_3 = book_1.reviews.create(title: "Joe Second is Better", description: "This book wasn't the worst thing I've ever read...", score: 3, user: user_1)
    
    review_4 = book_1.reviews.create(title: "Joe Second was an Okay book", description: "This book was not as bad as I thought...", score: 4, user: user_1)
    review_5 = book_1.reviews.create(title: "Joe Second is Really good", description: "This book was the very best thing I've ever read...", score: 5, user: user_1)
    review_6 = book_1.reviews.create(title: "Joe Second was the perfect_book", description: "So Amazeballs...", score: 5, user: user_1)

    visit book_path(book_1)
    within ('#top-reviews') do
      expect(page).to have_content("Joe Second is Really good")
      expect(page).to have_content("Joe Second was the perfect_book")
      expect(page).to have_content("Joe Second was an Okay book")
    end

    within ('#bottom-reviews') do
      expect(page).to have_content(review_3.title)
      expect(page).to have_content(review_2.title)
      expect(page).to have_content(review_1.title)
    end

    within ("#average-score") do
      expect(page).to have_content(3.5)
    end
  end
end
