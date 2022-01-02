class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.references  :attachable, polymorphic: true, null: false
      t.string      :image
      t.integer     :position

      t.timestamps
    end
  end
end
