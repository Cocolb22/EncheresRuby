# frozen_string_literal: true

require 'httparty'

class PokemonsController < ApplicationController
  before_action :fetch_pokemons, only: %i[index get_pokemon_image]

  def index
    @pokemons_names = @pokemons.map { |pokemon| pokemon['name']['fr'] }
    @first_gen_pokemons = @pokemons.select { |pokemon| pokemon['generation'] == 1 }
    @first_gen_pokemons_names = @first_gen_pokemons.map { |pokemon| pokemon['name']['fr'] }
  end

  def get_pokemon_image(pokemon_name)
    pokemon = @pokemons.find { |p| p['name']['fr'].downcase == pokemon_name.downcase }
    pokemon ? pokemon['sprites']['regular'] : nil
  end

  private

  def fetch_pokemons
    response = HTTParty.get('https://tyradex.vercel.app/api/v1/pokemon', query: { limit: 152, offset: 1 })
    @pokemons = JSON.parse(response.body).reject { |pokemon| pokemon['pokedex_id'].zero? }
  rescue StandardError => e
    Rails.logger.error "Failed to fetch pokemons: #{e.message}"
    @pokemons = []
  end
end
