class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :area_id, :integer, null: false, default: 0
    add_column :users, :introduction, :text
  end
end

