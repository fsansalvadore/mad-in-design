class AddPositionToWorkshopTeam < ActiveRecord::Migration[6.0]
  def change
    add_column :workshop_teams, :position, :integer
  end
end
