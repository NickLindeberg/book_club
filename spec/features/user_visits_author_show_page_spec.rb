require 'rails_helper'

describe 'User visits author show page' do
  it 'shows the correct author' do
    author_1 = Author.create(name: "Mary Sue")
    author_2 = Author.create(name: "John Gunn")
    author_3 = Author.create(name: "Jimmy Idunkeir")

    book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
    book_2 = author_1.books.create(title: "Joe 2", pages: 430, year: 1947)

    visit books_path    

    first(:link, "Mary Sue").click

    expect(current_path).to eq(author_path(author_1))
    expect(page).to have_content(author_1.name)
    expect(page).to have_content(book_1.title)
    expect(page).to have_content(book_1.year)
    expect(page).to have_content(book_1.pages)
    expect(page).to have_content(book_2.title)
    expect(page).to have_content(book_2.year)
    expect(page).to have_content(book_2.pages)
    expect(page).to_not have_content(author_3.name)
  end 

  it 'user clicks home link' do
    author_1 = Author.create(name: "Mary Sue")

    visit author_path(author_1)
    click_link "All Books"

    expect(current_path).to eq(books_path)
  end

  it 'has a button to delete authors' do
    author_1 = Author.create(name: "Mary Sue")
    author_2 = Author.create(name: "Freddi Sue")
    book_1 = Book.create(title: "A book about Joe", pages: 430, year: 1947)
    book_1.authors = [author_1, author_2]
    book_2 = author_1.books.create(title: "A book about Jones", pages: 430, year: 1947)
    user_1 = User.create(name: "Joey Fatone")
    review_1 = book_1.reviews.create(title: "Sharks are fun", description: "Who doesn't love a good shark...?", score: 5, user: user_1)
    review_2 = book_2.reviews.create(title: "Fish are better than Sharks", description: "Fish are friends", score: 3, user: user_1)

    visit author_path(author_1)

    click_link "Delete"

    expect(current_path).to eq(books_path)
    expect(page).to have_content(author_2.name)
    expect(page).to_not have_content(author_1.name)
    expect(page).to have_content(book_1.title)
  end

end 