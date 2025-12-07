class CreateChildren < ActiveRecord::Migration[6.1]
  def change
    create_table :children do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :age, null: false
      t.integer :gender, null: false

      t.timestamps
    end

    add_index :children, :age
    add_index :children, :gender
  end
end
