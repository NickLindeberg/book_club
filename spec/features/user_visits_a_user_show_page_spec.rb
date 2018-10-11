require 'rails_helper'

describe 'user visits user show page' do
  it 'shows information for one user' do

    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create(title: "A book about Joe", pages: 430, year: 1947)
    user_1 = User.create(name: "Joey Fatone")
    review_1 = book_1.reviews.create(title: "Sharks are fun", description: "Who doesn't love a good shark...?", score: 5, user: user_1)
  
    visit book_path(book_1)
    click_link "#{user_1.name}"
    expect(current_path).to eq(user_path(user_1))

    # title
    # rating
    # text

  end

end
