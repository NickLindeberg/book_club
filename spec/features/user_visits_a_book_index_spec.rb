require 'rails_helper'

describe 'user visits book index' do
  it 'shows all books and attributes' do
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
    book_2 = author_1.books.create(title: "Sharks", pages: 200, year: 1965)

    visit books_path

    expect(page).to have_content(book_1.title)
    within("#num-pages-1") do
      expect(page).to have_content(430)
    end
    within("#year-written-1") do
      expect(page).to have_content(1947)
    end
    within("#authors-list-1") do
      expect(page).to have_content("Mary Sue")
    end

    expect(page).to have_content(book_2.title)
    within("#num-pages-#{book_2.id}") do
      expect(page).to have_content(200)
    end
    within("#year-written-#{book_2.id}") do
      expect(page).to have_content(1965)
    end
    within("#authors-list-2") do
      expect(page).to have_content("Mary Sue")
    end
  end

  it 'shows books averages and total reviews' do
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
    user_1 = User.create(name: "Joey Fatone")
    review_1 = book_1.reviews.create(title: "Sharks are fun", description: "Who doesn't love a good shark...?", score: 5, user: user_1)
    review_2 = book_1.reviews.create(title: "Sharks are awful", description: "Only evil people love sharks...?", score: 1, user: user_1)

    visit books_path

    within("#total-reviews-#{book_1.id}") do
      expect(page).to have_content("Total Reviews: 2")
    end
    within("#avg-score-#{book_1.id}") do
      expect(page).to have_content("Average Rating: 3")
    end
  end
end
