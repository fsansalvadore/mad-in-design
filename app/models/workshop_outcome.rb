class WorkshopOutcome < ApplicationRecord
  belongs_to :workshop
  has_many :workshop_outcome_images
end
