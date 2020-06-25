class AddImageToWorkshopOutcomeImage < ActiveRecord::Migration[6.0]
  def change
    add_column :workshop_outcome_images, :image, :string
  end
end
