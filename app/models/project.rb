class Project < ApplicationRecord
  validates :title, presence: true
  validates :cover, size: {
                      less_than: 2000.kilobytes,
                      message: "deve pesare meno di 2MB" },
                    dimension: {
                      width: { max: 4000 },
                      height: { max: 3000 },
                      message: "deve avere un'altezza massima di 3000px e larghezza massima di 4000px" }

  has_many :project_content_sections, dependent: :destroy
  accepts_nested_attributes_for :project_content_sections,  allow_destroy: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one_attached :cover
end
