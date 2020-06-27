class Partner < ApplicationRecord
  validates :name, presence: true

  acts_as_list
end
