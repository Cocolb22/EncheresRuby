# frozen_string_literal: true

class ApplicationController < ActionController::Base
    before_action :set_locale
    before_action :authenticate_user!

    def change_locale
        I18n.locale = params[:locale] || I18n.default_locale
        redirect_to(request.referer || root_path)
    end

    private

    def set_locale
        I18n.locale = params[:locale] || I18n.default_locale
    end

end
