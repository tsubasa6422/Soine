class AddAgeMonthsToChildren < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:children, :age_months)
      add_column :children, :age_months, :integer
    end
  end
end
