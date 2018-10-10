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
end