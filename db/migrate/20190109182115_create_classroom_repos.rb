class CreateClassroomRepos < ActiveRecord::Migration[5.2]
  def change
    create_table :classroom_repos do |t|
      t.references :classroom, foreign_key: true
      t.references :repo, foreign_key: true

      t.timestamps
    end
  end
end
