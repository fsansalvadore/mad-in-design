class CreateSocials < ActiveRecord::Migration[6.0]
  def change
    create_table :socials do |t|
      t.string      :name
      t.string      :url
      t.string      :logo
      t.references  :site_global_settings, null: false, foreign_key: true

      t.timestamps
    end
  end
end
