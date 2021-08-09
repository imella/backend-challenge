class FriendshipSerializer < BaseSerializer
  belongs_to :member
  belongs_to :friend, record_type: :member
end
