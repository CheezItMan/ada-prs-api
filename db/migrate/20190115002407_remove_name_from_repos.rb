class RemoveNameFromRepos < ActiveRecord::Migration[5.2]
  def change
    remove_column :repos, :name
  end
end
