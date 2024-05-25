class RoomsController < ApplicationController
  include AuthorizeUserRoomAccess
  before_action :set_room, only: %i[show]
  before_action :set_rooms, only: %i[index show]
  before_action :authorize_user_room_access!, only: %i[show]

  def index
  end

  def show
    @user = @room.interlocutor(current_user)
    @message = @room.messages.new
  end

  def create
    interlocutor = User.find(params[:user_id])
    room = current_user.room_with(interlocutor)
    unless room
      room = Room.create
      room.room_users.create(user: current_user)
      room.room_users.create(user_id: params[:user_id])
    end
    redirect_to room_url(room)
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def set_rooms
    @rooms = current_user.rooms.includes(:users)
  end
end
