class AddLinkToPartners < ActiveRecord::Migration[6.0]
  def change
    add_column :partners, :link, :string, after: :name
  end
end
