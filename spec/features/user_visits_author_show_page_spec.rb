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
end 