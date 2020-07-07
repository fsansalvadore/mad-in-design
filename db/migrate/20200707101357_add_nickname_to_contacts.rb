class AddNicknameToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :nickname, :string
  end
end
