class Workshop < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  has_many :workshop_carousel_images,                             dependent: :destroy
  has_many :workshop_outcomes,                                    dependent: :destroy
  has_many :workshop_teams

  accepts_nested_attributes_for :workshop_carousel_images,        allow_destroy: true
  accepts_nested_attributes_for :workshop_outcomes,               allow_destroy: true
  accepts_nested_attributes_for :workshop_teams

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one_attached :cover
end
