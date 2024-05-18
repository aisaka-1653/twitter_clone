class FollowsController < ApplicationController
  before_action :set_user, :ensure_not_self!

  def create
    current_user.followers.create(followee_id: @user.id)
    redirect_to request.referer
  end

  def destroy
    current_user.followers.find_by(followee_id: @user.id).destroy!
    redirect_to request.referer
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def ensure_not_self!
    return unless current_user?(@user)

    redirect_to request.referer, alert: '自身はフォローできません'
  end
end
