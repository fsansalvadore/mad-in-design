class AddImageToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :image, :string
  end
end
