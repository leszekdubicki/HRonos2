class AddLevelToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :level, :integer
  end
end
