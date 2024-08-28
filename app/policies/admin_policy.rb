# frozen_string_literal: true

class AdminPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show_user?
    user.admin?
  end

  def destroy_user?
    user.admin?
  end

  def create_user?
    user.admin?
  end

  def show_article?
    user.admin?
  end

  def destroy_article?
    user.admin?
  end
end
