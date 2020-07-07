class AddColumnsToTeamOutcomes < ActiveRecord::Migration[6.0]
  def change
    add_column :team_outcomes, :image_1, :string
    add_column :team_outcomes, :image_2, :string
    add_column :team_outcomes, :image_3, :string
    add_column :team_outcomes, :image_4, :string
    add_column :team_outcomes, :image_5, :string
    add_column :team_outcomes, :content, :text
  end
end
