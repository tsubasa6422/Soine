class AddUnbornAndMonthsToChildren < ActiveRecord::Migration[6.1]
  def change
    add_column :children, :unborn, :boolean, default: false, null: false
    add_column :children, :due_on, :date
    add_column :children, :age_months, :integer

    
    change_column_null :children, :age, true
  end
end
