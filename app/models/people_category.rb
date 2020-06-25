class PeopleCategory < ApplicationRecord
  has_many :people

  acts_as_list
end
