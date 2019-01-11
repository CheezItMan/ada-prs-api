class RemoveClassRepoTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :classroom_repos
  end
end
