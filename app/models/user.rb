# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, :pseudo, presence: true
  validates :pseudo, :email, uniqueness: true
  validates :phone, numericality: { only_integer: true }, allow_blank: true, length: { is: 10 }

  has_many :articles, dependent: :destroy
  has_one_attached :avatar

  ROLES = %w[admin user].freeze

  validates :role, inclusion: { in: ROLES }

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end
end
