# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(id: 1, email: 'coco@test.com', password: 'password', first_name: 'Coco', last_name: 'LB', pseudo: 'Coco',
             credit: 1000, role: 'admin')

User.create!(id: 2, email: 'erle@test.com', password: 'password1', first_name: 'Erle', last_name: 'LB', pseudo: 'Erle',
             credit: 2000)

Article.create!(name: 'Pikachu', description: 'une souris jaune', start_date: DateTime.now + 1, end_date:  DateTime.now + 6,
                user_id: 1, first_price: 100, category: 'Electrik')

Article.create!(name: 'Dracaufeu', description: "l'ultime pokémon feu", start_date: DateTime.now + 1, end_date: DateTime.now + 2,
                user_id: 1, first_price: 100, category: 'Feu')

Article.create!(name: 'Carapuce', description: 'une tortue bleue', start_date: DateTime.now + 1, end_date: DateTime.now + 5,
                user_id: 2, first_price: 100, category: 'Eau')

Article.create!(name: 'Bulbizarre', description: 'une plante verte', start_date: DateTime.now + 1, end_date: DateTime.now + 4,
                user_id: 2, first_price: 100, category: 'Plante')

Article.create!(name: 'Salamèche', description: 'un lézard rouge', start_date: DateTime.now + 1, end_date: DateTime.now + 8,
                user_id: 2, first_price: 100, category: 'Feu')

Article.create!(name: 'Rattata', description: 'un rat violet', start_date: DateTime.now + 1, end_date: DateTime.now + 6,
                user_id: 1, first_price: 100, category: 'Normal')

Article.create!(name: 'Evoli', description: 'un pokémon aux nombreuses évolutions', start_date: DateTime.now + 1, end_date: DateTime.now + 7,
                user_id: 1, first_price: 100, category: 'Normal')

Article.create!(name: 'Ronflex', description: 'un énorme pokémon qui dort beaucoup', start_date: DateTime.now + 1, end_date: DateTime.now + 3,
                user_id: 2, first_price: 100, category: 'Normal')

Article.create!(name: 'Mewtwo', description: 'un pokémon légendaire', start_date: DateTime.now + 1, end_date: DateTime.now + 10,
                user_id: 1, first_price: 1000, category: 'Psy')

Article.create!(name: 'Dracolosse', description: 'un dragon puissant', start_date: DateTime.now + 1, end_date: DateTime.now + 5,
                user_id: 2, first_price: 1000, category: 'Dragon')

Article.create!(name: 'Lokhlass', description: 'un pokémon aquatique et glace', start_date: DateTime.now + 1, end_date: DateTime.now + 7,
                user_id: 1, first_price: 800, category: 'Eau/Glace')

Article.create!(name: 'Onix', description: 'un serpent de roche géant', start_date: DateTime.now + 1, end_date: DateTime.now + 6,
                user_id: 2, first_price: 500, category: 'Roche')

Article.create!(name: 'Magicarpe', description: 'un poisson rouge très faible', start_date: DateTime.now + 1, end_date: DateTime.now + 4,
                user_id: 1, first_price: 50, category: 'Eau')

Article.create!(name: 'Alakazam', description: 'un puissant pokémon psy', start_date: DateTime.now + 1, end_date: DateTime.now + 5,
                user_id: 2, first_price: 900, category: 'Psy')

Article.create!(name: 'Nidoking', description: 'un pokémon à la force colossale', start_date: DateTime.now + 1, end_date: DateTime.now + 7,
                user_id: 1, first_price: 700, category: 'Poison/Sol')

Article.create!(name: 'Gengar', description: 'un pokémon fantomatique', start_date: DateTime.now + 1, end_date: DateTime.now + 8,
                user_id: 2, first_price: 900, category: 'Spectre/Poison')
