class StudentSubmission < ApplicationRecord
  belongs_to :user
  belongs_to :submission
end
