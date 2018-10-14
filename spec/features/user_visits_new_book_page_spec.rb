require 'rails_helper'

describe 'user visits book index' do
  it 'shows link to create new book' do

    visit books_path

    click_link "Create Book"
    expect(current_path).to eq(new_book_path)
    fill_in 'book[title]', with: 'joy'
    fill_in 'author_names', with: 'Nick Lindy, Geoff Adebonojo'
    fill_in 'book[pages]', with: 900
    fill_in 'book[year]', with: 2000
    click_button "Create Book"
    new_book = Book.last
    expect(current_path).to eq(book_path(new_book))
    expect(page).to have_content('Joy')
    expect(page).to have_content(new_book.pages)
    expect(page).to have_content(new_book.year)
    expect(page).to have_content('Nick Lindy')
    expect(page).to have_content('Geoff Adebonojo')
    
  end

  it 'renders new book form if fields are incomplete' do
    visit books_path

    click_link "Create Book"
    click_button "Create Book"

    expect(current_path).to eq(new_book_path)
  end

end