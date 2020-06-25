class AddSlugToWorkshopTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :workshop_teams, :slug, :string
    add_index :workshop_teams, :slug, unique: true
  end
end
