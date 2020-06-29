class TecnicalSponsor < ApplicationRecord
  validates :logo, presence: true
  validates :logo, size: {
                      less_than: 200.kilobytes,
                      message: "deve pesare meno di 200 KB" },
                    dimension: {
                      width: { max: 1000 },
                      height: { max: 1000 },
                      message: "deve essere alta meno di 2000px e larga meno di 3000px" }

  has_one_attached :logo

  acts_as_list
end
