# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :pseudo, presence: true
  validates :pseudo, :email, uniqueness: true

  has_many :articles, dependent: :destroy

  ROLES = %w[admin user].freeze

  validates :role, inclusion: { in: ROLES }

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end
end
