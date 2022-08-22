class User < ApplicationRecord
  has_secure_password

  has_many :sent_friend_reqs, class_name: 'FriendRequest', foreign_key: 'sender_id'
  has_many :friend_req_receivers, through: :sent_friend_reqs, source: :receiver

  has_many :received_friend_reqs, class_name: 'FriendRequest', foreign_key: 'receiver_id'
  has_many :friend_req_senders, through: :received_friend_reqs, source: :sender

  has_many :friends, class_name: 'Friendship'

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
