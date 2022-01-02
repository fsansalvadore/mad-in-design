class AddIntroToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :intro, :string, after: :title
  end
end
