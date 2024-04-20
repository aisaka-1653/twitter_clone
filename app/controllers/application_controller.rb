# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_sign_up_params, if: :devise_controller?
  before_action :authenticate_user!

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[email display_name username date_of_birth mobile_number])
  end
end
