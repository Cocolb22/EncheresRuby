# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  # Autorise les utilisateurs à voir et modifier leur propre profil
  def show?
    user_is_owner?
  end

  def update?
    user_is_owner?
  end

  def edit?
    user_is_owner?
  end

  private

  def user_is_owner?
    user == record
  end
end
