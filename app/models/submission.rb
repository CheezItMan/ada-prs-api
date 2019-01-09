class Submission < ApplicationRecord
  # Relationships
  belongs_to :repo
  belongs_to :user, optional: true # no teacher update until grade submitted
  has_many :users, through: :studentsubmissions

  GRADES = {
    meet_standard: "meet_standard",
    approach_standard: "approach_standard",
    not_standard: "not_standard"
  }

  enum grade: GRADES

end
