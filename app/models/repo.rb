class Repo < ApplicationRecord

  has_many :classroomrepos
  has_many :classrooms, through: :classroomrepos

  validates :repo_url, presence: true

end
