# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user?
  before_action :configure_sign_up_params, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_unread_notifications, unless: :devise_controller?

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[email display_name username date_of_birth mobile_number])
  end

  private

  def current_user?(user)
    current_user == user
  end

  def set_unread_notifications
    @unread_notifications = current_user.received_notifications.unread
  end
end
