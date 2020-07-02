class AddPositionToWorkshopCarouselImages < ActiveRecord::Migration[6.0]
  def change
    add_column :workshop_carousel_images, :position, :integer
  end
end
