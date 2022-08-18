class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :password, presence: true, allow_nil: true
  validates :email, presence: true, uniqueness: true

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
