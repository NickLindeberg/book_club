class Review < ApplicationRecord
    validates_presence_of :title, :description, :score

end