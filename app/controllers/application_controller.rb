# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :last_name, :email, :password) }

    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :last_name, :email, :password, :current_password) }
  end

  def after_sign_in_path_for(resource)
    if resource.class != Headhunter
      return new_profile_path unless resource.profile

      resource.profile.attributes.each do |elem|
        return edit_profile_path(resource.profile) if elem[1].blank?
      end
      root_path
    else
      root_path
    end
  end
end
