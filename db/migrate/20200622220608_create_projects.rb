class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string    :title
      t.datetime  :start_date
      t.string    :cover
      t.boolean   :published
      t.boolean   :featured
      t.integer   :priority

      t.timestamps
    end
  end
end
