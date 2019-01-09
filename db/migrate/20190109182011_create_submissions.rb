class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.references :repo, foreign_key: true
      t.string :pr_url
      t.string :feedback_url
      t.string :grade

      t.timestamps
    end
  end
end
