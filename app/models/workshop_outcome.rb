class WorkshopOutcome < ApplicationRecord
  belongs_to :workshop

  has_one_attached :image_1
  has_one_attached :image_2
  has_one_attached :image_3
  has_one_attached :image_4
  has_one_attached :image_5
end
