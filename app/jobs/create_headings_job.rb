class CreateHeadingsJob < ApplicationJob
  queue_as :member

  def perform(member_id)
    member = Member.find(member_id)
    member.create_headings
  end
end
