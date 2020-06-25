class AddOutcomeImagesToWorkshopOutcomes < ActiveRecord::Migration[6.0]
  def change
    add_column :workshop_outcomes, :outcome_images, :string
  end
end
