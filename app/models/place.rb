class Place < ApplicationRecord
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.street.present? && obj.city.present? && obj.postal_code.present? && obj.country.present? && obj.street_changed? }

  validates :name, presence: true
  validates :place_type, presence: true
  validates :street, :postal_code, :city, presence: true

  CATEGORIES = ["Centre pokémon", "Arène", "Centre commercial"]

  def full_address
    "#{street}, #{postal_code}, #{city}, #{country}"
  end
end
