class FollowsController < ApplicationController
  def create
    current_user.followers.create(followee_id: params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.followers.find_by(followee_id: params[:user_id]).destroy!
    redirect_to request.referer
  end
end
