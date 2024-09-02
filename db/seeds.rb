# frozen_string_literal: true

require 'open-uri'
require 'httparty'

module PokemonsHelper
  def self.fetch_all_pokemons
    response = HTTParty.get('https://tyradex.vercel.app/api/v1/pokemon', query: { limit: 150, offset: 0 })
    JSON.parse(response.body).reject { |pokemon| pokemon['pokedex_id'].zero? }
  end

  def self.fetch_pokemon_image(pokemon_name)
    pokemons = fetch_all_pokemons
    pokemon = pokemons.find { |p| p['name']['fr'].downcase == pokemon_name.downcase }
    pokemon ? pokemon['sprites']['regular'] : nil
  end
end

Article.destroy_all

pokemon_names = %w[
  Pikachu Dracaufeu Carapuce Bulbizarre Salamèche
  Rattata Évoli Ronflex Mewtwo Dracolosse
  Lokhlass Onix Magicarpe Alakazam Nidoking Ectoplasma
]

pokemon_names.each do |pokemon_name|
  article = Article.new(
    name: pokemon_name,
    description: "Description pour le Pokémon #{pokemon_name}",
    start_date: DateTime.now + 1,
    end_date: DateTime.now + 6,
    user_id: User.pluck(:id).sample,
    first_price: rand(50..1000),
    category: 'Pokémon',
    status: 'Créée'
  )

  pokemon_image_url = PokemonsHelper.fetch_pokemon_image(pokemon_name)
  if pokemon_image_url
    begin
      image = URI.open(pokemon_image_url)
      article.image.attach(io: image, filename: "#{pokemon_name.downcase}.png", content_type: 'image/png')
    rescue OpenURI::HTTPError => e
      Rails.logger.warn "Failed to download image for Pokémon: #{pokemon_name}. Error: #{e.message}"
    end
  else
    Rails.logger.warn "Image not found for Pokémon: #{pokemon_name}"
  end

  article.save
end

puts 'Seed data created successfully!'
