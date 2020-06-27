class CreateTecnicalSponsors < ActiveRecord::Migration[6.0]
  def change
    create_table :tecnical_sponsors do |t|
      t.string :logo
      t.string :alt_text
      t.integer :position
      t.boolean   :published

      t.timestamps
    end
  end
end
