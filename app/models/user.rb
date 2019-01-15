class User < ApplicationRecord
  validates :name, presence: true
  validates :login, presence: true

  has_and_belongs_to_many :classrooms

  validates :email, presence: true, format: {with: /@/, message: "must include a @"}

  def admin?
    return self.admin
  end

  def pr_id
    self.pr_url.split("/").last
  end

  def update_group(attrs)
    if repo.individual?
      update(attrs)
    else
      Submission.grouped_with(self).update_all(attrs)
    end
  end

  def student_names
    if repo.individual?
      student.name
    else
      Submission.grouped_with(self).map do |sub|
        sub.student.name
      end.join(" & ")
    end
  end
end
