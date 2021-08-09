class FriendshipsController < BaseController
  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      render json: FriendshipSerializer.new(@friendship)
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:member_id, :friend_id)
  end
end
