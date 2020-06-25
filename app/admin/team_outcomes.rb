ActiveAdmin.register TeamOutcome do
  menu false
  # belongs_to :workshop_team
  controller do
    nested_belongs_to :workshop, :workshop_team
  end

end
