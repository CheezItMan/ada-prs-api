class Repo < ApplicationRecord
  has_and_belongs_to_many :classrooms

  validates :repo_url, presence: true

  BASE_GITHUB_URL = "https://github.com/"

  default_scope { order(created_at: :desc) }

  def name
    name = self.repo_url.split("/")[1]
    return name ? name : self.repo_url
  end

  def pulls_url
    full_repo_url + "/pulls"
  end

  def full_repo_url
    BASE_GITHUB_URL + self.repo_url
  end

  def branch_url
    full_repo_url + "/blob/master/"
  end

  def feedback_template_url
    branch_url + "feedback.md"
  end

  def pr_template_url
    branch_url + ".github/PULL_REQUEST_TEMPLATE"
  end

  def get_github_prs

  end
end
