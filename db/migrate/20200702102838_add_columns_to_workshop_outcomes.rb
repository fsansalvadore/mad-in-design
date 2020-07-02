class AddColumnsToWorkshopOutcomes < ActiveRecord::Migration[6.0]
  def change
    add_column :workshop_outcomes, :project_leader, :string
    add_column :workshop_outcomes, :team, :string
  end
end
