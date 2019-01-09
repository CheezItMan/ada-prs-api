# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Repo.create(repo_url: "https://github.com/ada-c10/inspiration-board", individual: true)

Repo.create(repo_url: "https://github.com/Ada-C10/video-store-consumer", individual: false)

Repo.create(repo_url: "https://github.com/Ada-C9/video-store-consumer", individual: false)

Classroom.create(cohort_number: 10, name: 'Nodes')
Classroom.create(cohort_number: 10, name: 'Edges')
Classroom.create(cohort_number: 9, name: 'Ampers')

ClassroomRepo.create(classroom: Classroom.find_by(name: 'Nodes'),
  repo_id: Repo.find_by(repo_url: 'https://github.com/ada-c10/inspiration-board').id)

ClassroomRepo.create(classroom: Classroom.find_by(name: 'Edges'),
  repo_id: Repo.find_by(repo_url: 'https://github.com/ada-c10/inspiration-board').id)

ClassroomRepo.create(classroom: Classroom.find_by(name: 'Ampers'),
  repo_id: Repo.find_by(repo_url: 'https://github.com/Ada-C9/video-store-consumer').id)

