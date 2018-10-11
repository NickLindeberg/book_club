require 'rails_helper'

describe 'user visits book index' do
  it 'shows link to create new book' do

    visit books_path

    click_link "Create Book"
    expect(current_path).to eq(new_book_path)
    fill_in 'book[title]', with: 'Joy'
    fill_in 'book[authors]', with: 'Dr. Nick'
    fill_in 'book[pages]', with: 900
    fill_in 'book[year]', with: 2000
    click_on "Create Book"
    new_book = Book.last
    expect(current_path). to eq(book_path(new_book))
  end

end