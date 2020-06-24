class CreateSpecialWorkshopDays < ActiveRecord::Migration[6.0]
  def change
    create_table :special_workshop_days do |t|
      t.string  :title
      t.text    :subtitle
      t.string  :cover
      t.integer :priority
      t.boolean :published, default: true
      t.string  :meta_title
      t.string  :meta_description
      t.string  :meta_keywords

      t.timestamps
    end
  end
end
