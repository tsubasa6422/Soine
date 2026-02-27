
class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.references :post, null: false, foreign_key: true

      t.bigint :reporter_id, null: false
      t.integer :reason, null: false, default: 0
      t.text :detail
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_foreign_key :reports, :users, column: :reporter_id
    add_index :reports, [:post_id, :reporter_id], unique: true
    add_index :reports, :status
  end
end