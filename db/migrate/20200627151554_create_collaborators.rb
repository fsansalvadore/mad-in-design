class CreateCollaborators < ActiveRecord::Migration[6.0]
  def change
    create_table :collaborators do |t|
      t.string :name
      t.string :link
      t.string :link_alt_text
      t.text :description
      t.string :photo
      t.integer :position
      t.boolean   :published

      t.timestamps
    end
  end
end
