class AddNameToChildren < ActiveRecord::Migration[6.1]
  def change
    add_column :children, :name, :string
  end
end
