class CreateClassrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :classrooms do |t|
      t.integer :cohort_number
      t.string :name

      t.timestamps
    end
  end
end
