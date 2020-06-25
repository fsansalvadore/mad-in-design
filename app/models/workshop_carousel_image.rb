class WorkshopCarouselImage < ApplicationRecord
  belongs_to :workshop

  has_many_attached :images
end
