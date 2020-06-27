class Project < ApplicationRecord
  validates :title, presence: true
  has_many :project_content_sections, dependent: :destroy
  accepts_nested_attributes_for :project_content_sections,  allow_destroy: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one_attached :cover
end
