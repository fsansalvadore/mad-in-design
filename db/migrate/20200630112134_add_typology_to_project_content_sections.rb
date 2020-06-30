class AddTypologyToProjectContentSections < ActiveRecord::Migration[6.0]
  def change
    add_column :project_content_sections, :typology, :integer, default: 0
  end
end
