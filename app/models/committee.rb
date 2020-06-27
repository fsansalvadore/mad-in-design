class Committee < ApplicationRecord
  validates :name, presence: true

  has_one_attached :photo

  acts_as_list
end
