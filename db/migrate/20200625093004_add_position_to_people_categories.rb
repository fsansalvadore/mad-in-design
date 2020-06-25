class AddPositionToPeopleCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :people_categories, :position, :integer
  end
end
