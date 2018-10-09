require 'rails_helper'

describe 'user visits book index' do
  it 'shows all books and attributes' do
    book_1 = Book.create(title: "A book about Joe", pages: 430, year: 1947)
    book_2 = Book.create(title: "Sharks", pages: 200, year: 1965)

    visit books_path

    expect(page).to have_content("Title: #{book_1.title}")
    expect(page).to have_content("Number of Pages: #{book_1.pages}")
    expect(page).to have_content("Year Written: #{book_1.year}")
    expect(page).to have_content("Title: #{book_2.title}")
    expect(page).to have_content("Number of Pages: #{book_2.pages}")
    expect(page).to have_content("Year Written: #{book_2.year}")
  end
end
