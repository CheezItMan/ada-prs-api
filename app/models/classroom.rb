class Classroom < ApplicationRecord

  has_many :classroomrepos
  has_many :repos, through: :classroomrepos

  validates :cohort_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true
end
