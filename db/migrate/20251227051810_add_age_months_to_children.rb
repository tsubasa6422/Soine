class AddAgeMonthsToChildren < ActiveRecord::Migration[6.1]
  def change
    add_column :children, :age_months, :integer
  end
end
