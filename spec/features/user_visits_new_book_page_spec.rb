require 'rails_helper'

describe 'user visits book index' do
  it 'shows link to create new book' do

    visit books_path

    click_link "Create Book"
    expect(current_path).to eq(new_book_path)

  end

end