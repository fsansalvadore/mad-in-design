class CreatePeopleCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :people_categories do |t|
      t.string  :title
      t.boolean :published, default: true

      t.timestamps
    end
  end
end
