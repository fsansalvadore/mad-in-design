class TeamOutcome < ApplicationRecord
  validates :title, presence: true
  validates :image_1, size: { less_than: 600.kilobytes, message: "deve pesare meno di 600KB" }, dimension: { width: { max: 3000 }, height: { max: 2000 }, message: "deve essere alta meno di 2000px e larga meno di 3000px" }
  validates :image_2, size: { less_than: 600.kilobytes, message: "deve pesare meno di 600KB" }, dimension: { width: { max: 3000 }, height: { max: 2000 }, message: "deve essere alta meno di 2000px e larga meno di 3000px" }
  validates :image_3, size: { less_than: 600.kilobytes, message: "deve pesare meno di 600KB" }, dimension: { width: { max: 3000 }, height: { max: 2000 }, message: "deve essere alta meno di 2000px e larga meno di 3000px" }
  validates :image_4, size: { less_than: 600.kilobytes, message: "deve pesare meno di 600KB" }, dimension: { width: { max: 3000 }, height: { max: 2000 }, message: "deve essere alta meno di 2000px e larga meno di 3000px" }
  validates :image_5, size: { less_than: 600.kilobytes, message: "deve pesare meno di 600KB" }, dimension: { width: { max: 3000 }, height: { max: 2000 }, message: "deve essere alta meno di 2000px e larga meno di 3000px" }

  belongs_to  :workshop_team

  extend FriendlyId
  friendly_id :title, use: :slugged

  has_one_attached :image_1
  has_one_attached :image_2
  has_one_attached :image_3
  has_one_attached :image_4
  has_one_attached :image_5
end
