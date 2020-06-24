class CreateWorkshopDayContentModules < ActiveRecord::Migration[6.0]
  def change
    create_table :workshop_day_content_modules do |t|
      t.text :rich_text
      t.string :image
      t.string :image_description
      t.integer :video_provider
      t.string :video_url
      t.boolean :visible
      t.integer :position
      t.references :special_workshop_day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
