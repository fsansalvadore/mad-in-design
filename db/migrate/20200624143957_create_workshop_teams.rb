class CreateWorkshopTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :workshop_teams do |t|
      t.string :title
      t.string :project_leader
      t.string :image
      t.references :workshop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
