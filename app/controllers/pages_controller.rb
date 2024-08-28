# frozen_string_literal: true

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @articles = Article.all
    @current_user_id = current_user&.id

    @articles = Article.order(:name).page(params[:article_page]).per(9)
  end
end
