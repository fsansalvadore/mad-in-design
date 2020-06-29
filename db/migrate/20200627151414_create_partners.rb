class CreatePartners < ActiveRecord::Migration[6.0]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :logo
      t.integer :position
      t.boolean :published

      t.timestamps
    end
  end
end
