class CreateRepos < ActiveRecord::Migration[5.2]
  def change
    create_table :repos do |t|
      t.string :repo_url
      t.boolean :individual

      t.timestamps
    end
  end
end
