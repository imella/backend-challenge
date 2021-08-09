class Friendship < ApplicationRecord
  belongs_to :member
  belongs_to :friend, class_name: "Member"

  validates :friend_id, uniqueness: { scope: :member_id }

  after_create :create_inverse_friendship

  private

  def create_inverse_friendship
    Friendship.create(member_id: friend.id, friend_id: member.id)
  end
end
