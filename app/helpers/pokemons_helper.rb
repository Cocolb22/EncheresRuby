# frozen_string_literal: true

module PokemonsHelper
  API_URL = 'https://tyradex.vercel.app/api/v1/pokemon'

  def self.fetch_pokemon_image(pokemon_name)
    pokemons = fetch_all_pokemons
    pokemon = pokemons.find { |p| p['name']['fr'].downcase == pokemon_name.downcase }
    pokemon ? pokemon['sprites']['regular'] : nil
  end

  def self.fetch_all_pokemons
    response = HTTParty.get(API_URL, query: { limit: 151, offset: 1 })
    JSON.parse(response.body).reject { |pokemon| pokemon['pokedex_id'].zero? }
  rescue StandardError => e
    Rails.logger.error "Failed to fetch pokemons: #{e.message}"
    []
  end
end
