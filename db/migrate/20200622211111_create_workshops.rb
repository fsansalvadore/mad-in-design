class CreateWorkshops < ActiveRecord::Migration[6.0]
  def change
    create_table :workshops do |t|
      t.integer   :type, default: 0
      t.string    :title
      t.text      :subtitle
      t.string    :cover
      t.string    :big_image
      t.text      :body_copy
      t.integer   :lang
      t.integer   :priority
      t.boolean   :published, default: false
      t.datetime  :publish_date
      t.string    :meta_title
      t.string    :meta_description
      t.string    :meta_keywords

      t.timestamps
    end
  end
end
