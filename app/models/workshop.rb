class Workshop < ApplicationRecord
  validates :title, presence: true
  validates :start_date, presence: true
  has_many :workshop_carousel_images,                             dependent: :destroy
  has_many :workshop_outcomes,                                    dependent: :destroy
  # has_many :workshop_outcome_images, through: :workshop_outcomes, dependent: :destroy
  has_many :workshop_teams
  # has_many :team_outcomes, through: :workshop_teams
  # has_many :team_outcome_modules, through: :team_outcomes,        dependent: :destroy
  accepts_nested_attributes_for :workshop_carousel_images,        allow_destroy: true
  accepts_nested_attributes_for :workshop_outcomes,               allow_destroy: true
  # accepts_nested_attributes_for :workshop_outcome_images,         allow_destroy: true
  accepts_nested_attributes_for :workshop_teams
  # accepts_nested_attributes_for :team_outcomes,                   allow_destroy: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  # mount_uploader :cover, CoverUploader

  has_one_attached :cover
end
