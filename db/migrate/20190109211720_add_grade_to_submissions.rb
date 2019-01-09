class AddGradeToSubmissions < ActiveRecord::Migration[5.2]
  def up
    remove_column :submissions, :grade
    execute <<-SQL
      CREATE TYPE submission_grade AS ENUM ('not_standard', 'approach_standard', 'meet_standard');
    SQL
    add_column :submissions, :grade, :submission_grade
  end

  def down
    remove_column :submissions, :grade
    execute <<-SQL
      DROP TYPE submission_grade;
    SQL
  end
end
