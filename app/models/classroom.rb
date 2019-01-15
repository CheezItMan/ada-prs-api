class Classroom < ApplicationRecord
  has_and_belongs_to_many :repos
  has_and_belongs_to_many :users

  validates :cohort_number, presence: true, numericality: {only_integer: true, greater_than: 0}
  validates :name, presence: true

  def display_name
    "#{cohort_number}: #{name}"
  end
end
