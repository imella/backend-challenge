require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:member) { Member.create(first_name: "Carl", "last_name": "Sagan", url: "https://carlsagan.com") }
  let(:friend) { Member.create(first_name: "Michael", "last_name": "Faraday", url: "https://faraday.com") }
  let!(:friendship) { Friendship.create(member_id: member.id, friend_id: friend.id) }

  it 'creates the inverse relationship' do
    expect(friend.friends.size).to eq(1)
  end

  it 'validates uniqueness of one side relation' do
    dupliate_friendship = Friendship.create(member_id: member.id, friend_id: friend.id)

    expect(dupliate_friendship.valid?).to be_falsy
  end
end
