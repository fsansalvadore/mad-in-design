class WorkshopTeam < ApplicationRecord
  validates :title, presence: true
  belongs_to  :workshop
  has_many    :team_outcomes, dependent: :destroy
  has_many    :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :team_outcomes, allow_destroy: true
  accepts_nested_attributes_for :attachments,   allow_destroy: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one_attached :image
end
