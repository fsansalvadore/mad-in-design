class ChangeSubtitleToWorkshops < ActiveRecord::Migration[6.0]
  def change
    change_column :workshops, :subtitle, :string
  end
end
