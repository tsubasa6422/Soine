class AddIsHiddenToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :is_hidden, :boolean, null: false, default: false
    add_index :posts, :is_hidden
  end
end