class TeamOutcome < ApplicationRecord
  validates :title, presence: true
  belongs_to  :workshop_team
  belongs_to  :workshop
  # has_many    :team_outcome_content_modules, dependent: :destroy
  # accepts_nested_attributes_for :team_outcome_content_modules,  allow_destroy: true

  extend FriendlyId
  friendly_id :title, use: :slugged
end
