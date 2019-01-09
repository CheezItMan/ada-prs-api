class Repo < ApplicationRecord
  validates :repo_url, presence: true
end
