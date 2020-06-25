class WorkshopTeam < ApplicationRecord
  belongs_to  :workshop
  has_many    :team_outcomes
  # has_many    :team_outcome_content_modules, through: :team_outcomes, dependent: :destroy
  accepts_nested_attributes_for :team_outcomes,  allow_destroy: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one_attached :image
end
