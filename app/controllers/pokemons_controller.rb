require "httparty"

class PokemonsController < ApplicationController

    def index
      response = HTTParty.get('https://tyradex.vercel.app/api/v1/pokemon', query: { limit: 151, offset: 1 })
      @pokemons = JSON.parse(response.body).reject { |pokemon| pokemon['pokedex_id'] == 0 }

      @pokemons_names = @pokemons.map { |pokemon| pokemon['name']['fr'] }
      @first_gen_pokemons_names = @pokemons_names[1..151]

      @first_gen_pokemons = []
      @first_gen_pokemons = @pokemons.select { |pokemon| pokemon['generation'] == 1 }
    end

end
