class AddBannerCtaToHomePages < ActiveRecord::Migration[6.0]
  def change
    add_column :home_pages, :banner_cta_visibility, :boolean
    add_column :home_pages, :banner_cta_link, :string
    add_column :home_pages, :banner_cta_text, :string
  end
end
