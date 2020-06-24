class CreateWorkshopCarouselImages < ActiveRecord::Migration[6.0]
  def change
    create_table :workshop_carousel_images do |t|
      t.string      :image
      t.references  :workshop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
