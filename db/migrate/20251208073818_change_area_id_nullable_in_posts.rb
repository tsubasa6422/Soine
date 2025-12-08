class ChangeAreaIdNullableInPosts < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :area_id, true
  end
end
