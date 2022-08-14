class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :password, presence: true, allow_nil: true
  validates :email, presence: true, uniqueness: true
end
