class CreateTeamOutcomes < ActiveRecord::Migration[6.0]
  def change
    create_table :team_outcomes do |t|
      t.string :title
      t.text :subtitle
      t.string :cover
      t.integer :priority
      t.boolean :published
      t.string :meta_title
      t.string :meta_description
      t.string :meta_keywords
      t.references :workshop_team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
