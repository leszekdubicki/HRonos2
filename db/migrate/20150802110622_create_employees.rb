class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.text :first_name
      t.text :last_name
      t.date :start_date
      t.decimal :salary
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
