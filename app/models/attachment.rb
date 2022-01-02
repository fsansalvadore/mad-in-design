class Attachment < ApplicationRecord
  belongs_to :attachable, polymorphic: true
  validates :image, size: {
                      less_than: 2000.kilobytes,
                      message: "deve pesare meno di 2000 KB" },
                    dimension: {
                      width: { max: 3000 },
                      height: { max: 2000 },
                      message: "deve essere alta meno di 2000px e larga meno di 3000px" }

  has_one_attached :image
end
