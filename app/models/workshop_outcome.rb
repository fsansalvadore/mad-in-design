class WorkshopOutcome < ApplicationRecord
  belongs_to :workshop
  has_many :workshop_outcome_images
  accepts_nested_attributes_for :workshop_outcome_images,  allow_destroy: true

  has_many_attached :outcome_images
  has_one_attached :image_1
  has_one_attached :image_2
  has_one_attached :image_3
  has_one_attached :image_4
  has_one_attached :image_5
end
