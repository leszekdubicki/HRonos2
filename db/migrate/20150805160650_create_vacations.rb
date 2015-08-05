class CreateVacations < ActiveRecord::Migration
  def change
    create_table :vacations do |t|
      t.references :employee, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.text :employee_comments
      t.text :manager_comments
      t.integer :state

      t.timestamps null: false
    end
  end
end
