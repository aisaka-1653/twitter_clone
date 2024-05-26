# frozen_string_literal: true

class MessagesController < ApplicationController
  include AuthorizeUserRoomAccess
  before_action :set_room, only: %i[create]
  before_action :authorize_user_room_access!, only: %i[create]

  def create
    @message = current_user.messages.build(message_params)
    @message.room = @room
    flash[:danger] = @message.errors.full_messages[0] unless @message.save
    redirect_to room_path(@room)
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
