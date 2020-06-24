class CreateWorkshopOutcomeImages < ActiveRecord::Migration[6.0]
  def change
    create_table :workshop_outcome_images do |t|
      t.references :workshop_outcome, null: false, foreign_key: true

      t.timestamps
    end
  end
end
