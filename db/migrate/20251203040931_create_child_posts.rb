class CreateChildPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :child_posts do |t|
      t.references :child, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end

    add_index :child_posts, [:child_id, :post_id], unique: true
  end
end
