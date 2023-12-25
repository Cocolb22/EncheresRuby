# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  has_many :bids
  has_one_attached :image

  validates :name, :description, :first_price, :start_date, :end_date, presence: true
  validates :first_price, numericality: { greater_than_or_equal_to: 1 }
  validates :name, uniqueness: true
  validates :description, length: { minimum: 10 }
  validate :date_debut_cannot_be_in_the_past
  validate :date_fin_cannot_be_in_the_past
  validate :date_fin_cannot_be_before_date_debut

  CATEGORIES = ['Pokémon combat', 'Pokémon eau', 'Pokémon feu', 'Pokémon plante', 'Pokémon électrique', 'Pokémon vol',
                'Pokémon poison', 'Pokémon sol', 'Pokémon roche', 'Pokémon insecte', 'Pokémon spectre', 'Pokémon ténèbres', 'Pokémon psy', 'Pokémon acier', 'Pokémon glace', 'Pokémon dragon', 'Pokémon fée'].freeze

  def date_debut_cannot_be_in_the_past
    return unless start_date.present? && start_date < Date.today

    errors.add(:start_date, 'ne peut pas être dans le passé')
  end

  def date_fin_cannot_be_in_the_past
    return unless end_date.present? && end_date < Date.today

    errors.add(:end_date, 'ne peut pas être dans le passé')
  end

  def date_fin_cannot_be_before_date_debut
    return unless start_date.present? && end_date.present? && end_date < start_date

    errors.add(:end_date, 'ne peut pas être avant la date de début')
  end
end
