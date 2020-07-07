class AddDescriptionToWorkshopTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :workshop_teams, :description, :text
  end
end
