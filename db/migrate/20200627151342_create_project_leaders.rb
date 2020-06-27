class CreateProjectLeaders < ActiveRecord::Migration[6.0]
  def change
    create_table :project_leaders do |t|
      t.string :name
      t.string :role
      t.text :description
      t.string :photo
      t.integer :year
      t.integer :position
      t.boolean   :published

      t.timestamps
    end
  end
end
