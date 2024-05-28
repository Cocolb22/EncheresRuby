# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(id: 1, email: 'coco@test.com', password: 'password', first_name: 'Coco', last_name: 'LB', pseudo: 'Coco', credit: 1000)

User.create!(id: 2, email: 'erle@test.com', password: 'password1', first_name: 'Erle', last_name: 'LB', pseudo: 'Erle', credit: 2000)

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
