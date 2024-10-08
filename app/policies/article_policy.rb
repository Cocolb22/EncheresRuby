# frozen_string_literal: true

class ArticlePolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def edit?
    user.present? && article.user == user
  end

  def update?
    user.present? && article.user == user
  end

  def destroy?
    user.admin? || article.user == user
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
