class FriendshipsController < AplicationController
  before_action :find_friend

  def create
    friendship = Friendship.create(user: current_user, friend: @friend)
  end

  private

  def find_friend
    @friend = User.find(params:[friend_id])
  end

  def find_model

  end

end
