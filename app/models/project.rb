class Project < ApplicationRecord
  validates :title, presence: true
  validates :cover, size: {
                      less_than: 1000.kilobytes,
                      message: "deve pesare meno di 1MB" },
                    dimension: {
                      width: { max: 3000 },
                      height: { max: 2000 },
                      message: "deve essere alta meno di 2000px e larga meno di 3000px" }

  has_many :project_content_sections, dependent: :destroy
  accepts_nested_attributes_for :project_content_sections,  allow_destroy: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one_attached :cover
end
