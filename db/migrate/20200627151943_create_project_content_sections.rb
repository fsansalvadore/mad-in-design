class CreateProjectContentSections < ActiveRecord::Migration[6.0]
  def change
    create_table :project_content_sections do |t|
      t.text :rich_text
      t.string :image
      t.string :image_width
      t.integer :video_provider
      t.string :video_url
      t.integer :position
      t.boolean :published, default: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
