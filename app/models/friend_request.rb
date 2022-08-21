class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  # I decided to use class methods instead of scope
  # because I need these to return nil when no
  # matching records are found
  def self.to(user)
    find_by(receiver_id: user.id)
  end

  # Rails already defines a 'from' method for FriendRequest
  # which is why I am using custom_from
  def self.custom_from(user)
    find_by(sender_id: user.id)
  end
end
