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

  it 'shows a stats bar with highest and lowest rated books' do

    user_1 = User.create(name: "Joey Fatone")
    user_2 = User.create(name: "Justin Timberlake")
    user_3 = User.create(name: "Lance Bass")
    user_4 = User.create(name: "Carl Malone")
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "Joe, First", pages: 430, year: 1947)
    book_2 = author_1.books.create(title: "Joe, second", pages: 563, year: 1947)
    book_3 = author_1.books.create(title: "Joe, third", pages: 234, year: 1947)
    book_4 = author_1.books.create(title: "Joe, fourth", pages: 456, year: 1947)
    book_5 = author_1.books.create(title: "Joe, fifth", pages: 900, year: 1947)
    book_6 = author_1.books.create(title: "Joe, sixth", pages: 390, year: 1947)

    review_1 = book_1.reviews.create(title: "Joe First is Awful", description: "I hated this book so much...", score: 2, user: user_1)
    review_2 = book_1.reviews.create(title: "Joe First was pretty Bad", description: "This book was not as bad as I thought...", score: 2, user: user_1)
    review_3 = book_2.reviews.create(title: "Joe Second is Better", description: "This book wasn't the worst thing I've ever read...", score: 5, user: user_1)
    review_4 = book_2.reviews.create(title: "Joe Second was an Okay book", description: "This book was not as bad as I thought...", score: 5, user: user_1)

    review_5 = book_3.reviews.create(title: "Joe Third is Good", description: "This book was really good...", score: 5, user: user_2)
    review_6 = book_3.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_2)
    review_7 = book_4.reviews.create(title: "This book is awesome", description: "This is poorly written...", score: 5, user: user_2)
    review_8 = book_4.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 5, user: user_3)

    review_9 = book_5.reviews.create(title: "Joe Third is my new Favorite book", description: "This book is amazing it's the best thing...", score: 2, user: user_3)
    review_10 = book_5.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 2, user: user_4)
    review_11 = book_6.reviews.create(title: "Joe Third is my new Favorite book", description: "This book is amazing it's the best thing...", score: 1, user: user_3)
    review_12 = book_6.reviews.create(title: "Joe Third is my Favorite book", description: "This book is amazing it's the best thing...", score: 1, user: user_4)

    visit books_path

    within('#highest-rated') do
      expect(page).to have_content(book_2.title)
      expect(page).to have_content(book_3.title)
      expect(page).to have_content(book_4.title)
    end

    within('#lowest-rated') do
      expect(page).to have_content(book_1.title)
      expect(page).to have_content(book_5.title)
      expect(page).to have_content(book_6.title)
    end

  end

  it 'shows the three users who have written the most reviews' do
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

    visit books_path
    within('#top-users') do
      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_2.name)
      expect(page).to have_content(user_3.name)
    end
  end

  it 'sorts books by page number, highest/lowest' do
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "Joe, I", pages: 430, year: 1947)
    book_2 = author_1.books.create(title: "Joe, II", pages: 450, year: 1947)
    book_3 = author_1.books.create(title: "Joe, III", pages: 470, year: 1947)

    visit books_path
    save_and_open_page
    click_on "Longest"

    expect(all('.book-entry')[0]).to have_content(book_3.title)

  end

end
