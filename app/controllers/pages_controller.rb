# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @articles = Article.all
    @current_user_id = current_user&.id
  end
end
