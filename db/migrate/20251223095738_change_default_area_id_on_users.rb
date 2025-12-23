class ChangeDefaultAreaIdOnUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :area_id, from: 0, to: nil
    change_column_null :users, :area_id, true
  end
end
