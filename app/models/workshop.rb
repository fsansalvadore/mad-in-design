class Workshop < ApplicationRecord
  validates :title, presence: true
  has_many :workshop_carousel_images,                             dependent: :destroy
  has_many :workshop_outcomes,                                    dependent: :destroy
  # has_many :workshop_outcome_images, through: :workshop_outcomes, dependent: :destroy
  has_many :workshop_teams
  has_many :team_outcomes, through: :workshop_teams
  # has_many :team_outcome_modules, through: :team_outcomes,        dependent: :destroy
  accepts_nested_attributes_for :workshop_carousel_images,        allow_destroy: true
  accepts_nested_attributes_for :workshop_outcomes,               allow_destroy: true
  # accepts_nested_attributes_for :workshop_outcome_images,         allow_destroy: true
  accepts_nested_attributes_for :workshop_teams,                  allow_destroy: true
  # accepts_nested_attributes_for :team_outcomes,                   allow_destroy: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  # mount_uploader :cover, CoverUploader

  has_one_attached :cover
  has_one_attached :outcome_1_img_1
  has_one_attached :outcome_1_img_2
  has_one_attached :outcome_1_img_3
  has_one_attached :outcome_1_img_4
  has_one_attached :outcome_1_img_5
  has_one_attached :outcome_2_img_1
  has_one_attached :outcome_2_img_2
  has_one_attached :outcome_2_img_3
  has_one_attached :outcome_2_img_4
  has_one_attached :outcome_2_img_5
  has_one_attached :outcome_3_img_1
  has_one_attached :outcome_3_img_2
  has_one_attached :outcome_3_img_3
  has_one_attached :outcome_3_img_4
  has_one_attached :outcome_3_img_5
  has_one_attached :outcome_4_img_1
  has_one_attached :outcome_4_img_2
  has_one_attached :outcome_4_img_3
  has_one_attached :outcome_4_img_4
  has_one_attached :outcome_4_img_5
  has_one_attached :outcome_5_img_1
  has_one_attached :outcome_5_img_2
  has_one_attached :outcome_5_img_3
  has_one_attached :outcome_5_img_4
  has_one_attached :outcome_5_img_5
  has_one_attached :outcome_6_img_1
  has_one_attached :outcome_6_img_2
  has_one_attached :outcome_6_img_3
  has_one_attached :outcome_6_img_4
  has_one_attached :outcome_6_img_5
end
