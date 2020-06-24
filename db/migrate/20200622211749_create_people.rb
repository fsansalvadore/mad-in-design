class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.references  :people_category, null: false, foreign_key: true
      t.string      :first_name
      t.string      :last_name
      t.string      :role
      t.text        :description
      t.boolean     :published, default: true

      t.timestamps
    end
  end
end
