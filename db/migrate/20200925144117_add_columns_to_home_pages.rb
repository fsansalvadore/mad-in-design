class AddColumnsToHomePages < ActiveRecord::Migration[6.0]
  def change
    add_column :home_pages, :graphics_visibility, :boolean
    add_column :home_pages, :box_1_label,         :string
    add_column :home_pages, :box_1_text,          :text
    add_column :home_pages, :box_1_url,           :string
    add_column :home_pages, :box_1_cta,           :string
    add_column :home_pages, :box_1_image,         :string
    add_column :home_pages, :box_2_label,         :string
    add_column :home_pages, :box_2_text,          :text
    add_column :home_pages, :box_2_url,           :string
    add_column :home_pages, :box_2_cta,           :string
    add_column :home_pages, :box_3_label,         :string
    add_column :home_pages, :box_3_text,          :text
    add_column :home_pages, :box_3_url,           :string
    add_column :home_pages, :box_3_cta,           :string
  end
end
