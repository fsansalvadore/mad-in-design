ActiveAdmin.register WorkshopOutcomeImage do
  belongs_to :workshop_outcome
  # belongs_to :workshop, through: :workshop_outcome

  menu false

  controller do
    nested_belongs_to :workshop, :workshop_outcome
  end
end
