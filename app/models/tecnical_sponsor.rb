class TecnicalSponsor < ApplicationRecord
  validates :logo, presence: true

  has_one_attached :logo

  acts_as_list
end
