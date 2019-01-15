# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"

Repo.destroy_all
Classroom.destroy_all
User.destroy_all

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

Repo.create(repo_url: "Ada-C10/inspiration-board", individual: true)

Repo.create(repo_url: "Ada-C10/video-store-consumer", individual: false)

Repo.create(repo_url: "Ada-C9/video-store-consumer", individual: false)

Classroom.create(cohort_number: 10, name: "Nodes")
Classroom.create(cohort_number: 10, name: "Edges")
Classroom.create(cohort_number: 9, name: "Ampers")

Classroom.first.repos << Repo.first
Classroom.find_by(name: "Edges").repos << Repo.find_by(repo_url: "Ada-C10/video-store-consumer")
Classroom.find_by(name: "Edges").repos << Repo.find_by(repo_url: "Ada-C10/inspiration-board")

Classroom.find_by(name: "Ampers").repos << Repo.find_by(repo_url: "Ada-C9/video-store-consumer")

csv_text = File.read("db/seed_data/students.csv")
CSV.parse(csv_text, headers: true).each do |row|
  User.create(row.to_h)
end

csv_text = File.read("db/seed_data/student-classroom.csv")
CSV.parse(csv_text, headers: true).each do |row|
  row_h = row.to_h
  user = User.find_by(uid: row["uid"].to_s)
  classroom = Classroom.find_by(cohort_number: row_h["cohort"].to_i, name: row_h["classroom_name"])

  classroom.users << user
end
