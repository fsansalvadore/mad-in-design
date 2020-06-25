class AddImagesToWorkshopOutcomes < ActiveRecord::Migration[6.0]
  def change
    add_column :workshop_outcomes, :image_1, :string
    add_column :workshop_outcomes, :image_2, :string
    add_column :workshop_outcomes, :image_3, :string
    add_column :workshop_outcomes, :image_4, :string
    add_column :workshop_outcomes, :image_5, :string
  end
end
