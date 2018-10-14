require 'rails_helper'

describe 'user visits book show' do
  it 'shows a link to create a new review' do
    author_1 = Author.create(name: "Mary Sue")
    book_1 = author_1.books.create!(title: "A book about Joe", pages: 430, year: 1947)

    visit book_path(book_1)

    click_link "Write a Review"

    fill_in 'review[title]', with: 'This was a stupid book'
    fill_in 'user_name', with: 'Nick Lindy'
    fill_in 'review[score]', with: 1
    fill_in 'review[description]', with: 'I did not like this book at all, it was not funny and it made me feel like an awful person'
    click_on 'Create Review'

    new_review = Review.last
    expect(current_path).to eq(book_path(book_1))
    expect(page).to have_content(new_review.title)
    expect(page).to have_content(new_review.user.name)
    expect(page).to have_content(new_review.score)
    expect(page).to have_content(new_review.description)
  end
end
