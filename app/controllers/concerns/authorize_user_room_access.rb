module AuthorizeUserRoomAccess
  extend ActiveSupport::Concern

  private

  def authorize_user_room_access!
    return if @room.users.exists?(current_user.id)

    flash[:alert] = "アクセス権限がありません"
    redirect_to rooms_url
  end
end