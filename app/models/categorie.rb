# frozen_string_literal: true

class Categorie < ApplicationRecord
  has_many :articles

  CATEGORIES = ['Pokémon combat', 'Pokémon eau', 'Pokémon feu', 'Pokémon plante', 'Pokémon électrique', 'Pokémon vol',
                'Pokémon poison', 'Pokémon sol', 'Pokémon roche', 'Pokémon insecte', 'Pokémon spectre', 'Pokémon ténèbres', 'Pokémon psy', 'Pokémon acier', 'Pokémon glace', 'Pokémon dragon', 'Pokémon fée'].freeze

  @categories = CATEGORIES
  @categories.each do |categorie|
    categorie.add(categorie_id: categorie)
  end
end
