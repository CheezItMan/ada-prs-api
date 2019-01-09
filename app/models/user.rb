class User < ApplicationRecord
  validates :name, presence: true
  validates :login, presence: true

  validates :email, presence: true, format: { with: /@/, message: 'must include a @' }

  def admin?
    return self.admin
  end
end
