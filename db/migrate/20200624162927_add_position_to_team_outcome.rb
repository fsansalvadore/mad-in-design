class AddPositionToTeamOutcome < ActiveRecord::Migration[6.0]
  def change
    add_column :team_outcomes, :position, :integer
  end
end
