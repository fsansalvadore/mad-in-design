class Workshop < ApplicationRecord
  has_many :workshop_carousel_images
  has_many :workshop_outcomes
end
