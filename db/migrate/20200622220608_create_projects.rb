class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string    :title
      t.string    :meta_title
      t.string    :meta_description
      t.string    :meta_keywords
      t.datetime  :start_date
      t.string    :cover
      t.string    :highlight_image
      t.boolean   :published
      t.boolean   :featured
      t.integer   :priority

      t.timestamps
    end
  end
end
