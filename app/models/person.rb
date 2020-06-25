class Person < ApplicationRecord
  belongs_to :people_category

  has_one_attached :image
end
