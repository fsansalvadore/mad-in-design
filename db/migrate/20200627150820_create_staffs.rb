class CreateStaffs < ActiveRecord::Migration[6.0]
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :role
      t.text :description
      t.string :photo
      t.integer :position

      t.timestamps
    end
  end
end
