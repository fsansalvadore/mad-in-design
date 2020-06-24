class AddStartDateToWorkshops < ActiveRecord::Migration[6.0]
  def change
    add_column :workshops, :start_date, :datetime
    add_column :workshops, :end_date, :datetime
  end
end
