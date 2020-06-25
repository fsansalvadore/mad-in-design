class AddSlugToTeamOutcomes < ActiveRecord::Migration[6.0]
  def change
    add_column :team_outcomes, :slug, :string
    add_index :team_outcomes, :slug, unique: true
  end
end
