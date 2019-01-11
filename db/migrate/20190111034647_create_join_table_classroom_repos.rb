class CreateJoinTableClassroomRepos < ActiveRecord::Migration[5.2]
  def change
    create_join_table :classrooms, :repos do |t|
      # t.index [:classroom_id, :repo_id]
      # t.index [:repo_id, :classroom_id]
    end
  end
end
