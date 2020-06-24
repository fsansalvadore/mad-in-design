class CreateWorkshopOutcomes < ActiveRecord::Migration[6.0]
  def change
    create_table :workshop_outcomes do |t|
      t.references  :workshop, null: false, foreign_key: true
      t.string      :title
      t.string      :sottotitolo
      t.text        :content
      t.boolean     :visible, default: true
      t.integer     :position

      t.timestamps
    end
  end
end
