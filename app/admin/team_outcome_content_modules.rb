ActiveAdmin.register TeamOutcomeContentModule do
  menu false

  controller do
    nested_belongs_to :workshop, :workshop_team, :team_outcomes
  end
end
