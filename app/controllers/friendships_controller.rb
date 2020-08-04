class FriendshipsController < AplicationController
  before_action :find_friend

  def create
    current_user
  end


end
