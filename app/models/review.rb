class Review < ApplicationRecord
    validates_presence_of :title, :description, :score

    belongs_to :user
    belongs_to :book

    def self.total_reviews
        Review.count
    end

    def self.avg_score
        average(:score)
    end
end