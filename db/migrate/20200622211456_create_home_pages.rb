class CreateHomePages < ActiveRecord::Migration[6.0]
  def change
    create_table :home_pages do |t|
      t.string  :meta_title
      t.string  :meta_description
      t.string  :meta_keywords
      t.boolean :banner_visibility
      t.string  :banner_image
      t.string  :main_title_one
      t.string  :main_title_two
      t.string  :subtitle
      t.boolean :sticky_box_visibility
      t.string  :sticky_box_text
      t.string  :sticky_box_link_url
      t.string  :sticky_box_cta_text
      t.string  :chi_siamo_box_label
      t.text    :chi_siamo_box_text
      t.string  :chi_siamo_box_cta
      t.string  :people_box_label
      t.string  :people_box_text
      t.string  :people_box_cta
      t.string  :contacts_box_label
      t.string  :contacts_box_text
      t.string  :contacts_box_cta

      t.timestamps
    end
  end
end
