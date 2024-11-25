# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: [:create]
  after_action :add_credit_to_user, only: [:create]

  private

  def add_credit_to_user
    resource.update(credit: (resource.credit || 0) + 1000)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name pseudo])
  end
end
