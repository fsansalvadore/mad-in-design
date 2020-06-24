class CreateSiteGlobalSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :site_global_settings do |t|
      t.string  :site_name
      t.integer :maintenance_mode
      t.text    :maintenance_message
      t.integer :language
      t.string  :favicon
      t.string  :google_verification_code
      t.integer :background_decoration

      t.timestamps
    end
  end
end
