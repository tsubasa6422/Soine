class AddChildSnapshotToChildPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :child_posts, :child_name, :string
    add_column :child_posts, :child_age, :integer
    add_column :child_posts, :child_age_months, :integer
    add_column :child_posts, :child_gender, :integer
  end
end
