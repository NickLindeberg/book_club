require 'faker'

6.times do
  author = Author.create(name: Faker::Simpsons.character)
    book_1 = author.books.create(
      title: Faker::Book.title,
      pages: Faker::Number.between(100, 1000),
      year: Faker::Number.between(1980, 2015))
    book_2 = author.books.create(
      title: Faker::Book.title,
      pages: Faker::Number.between(100, 1000),
      year: Faker::Number.between(1980, 2015))
    book_3 = author.books.create(
      title: Faker::Book.title,
      pages: Faker::Number.between(100, 1000),
      year: Faker::Number.between(1980, 2015))
    3.times do
      user = User.create(name: Faker::Simpsons.character )
      book_1.reviews.create(title: Faker::Lorem.sentence(5).to_s, description: Faker::ChuckNorris.fact, score: Faker::Number.between(1, 5), user: user)
      book_2.reviews.create(title: Faker::Lorem.sentence(5).to_s, description: Faker::ChuckNorris.fact, score: Faker::Number.between(1, 5), user: user)
      book_3.reviews.create(title: Faker::Lorem.sentence(5).to_s, description: Faker::ChuckNorris.fact, score: Faker::Number.between(1, 5), user: user)
  end
end
