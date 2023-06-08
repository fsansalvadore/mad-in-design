class ProjectContentSection < ApplicationRecord
  belongs_to :project
  validates :image, size: {
                      less_than: 1500.kilobytes,
                      message: "deve pesare meno di 1.5MB" },
                    dimension: {
                      width: { max: 3000 },
                      height: { max: 2000 },
                      message: "deve essere alta meno di 2000px e larga meno di 3000px" }

  has_one_attached :image
end
