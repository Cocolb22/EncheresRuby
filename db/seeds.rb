# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(id: 1, email:"coco@test.com", password:"password", first_name:"Coco", last_name:"LB", pseudo:"Coco")

Article.create!(name: "Pikachu", description:"une souris jaune", start_date: Date.today, end_date: Date.today+1, user_id:1, first_price: 100)

Article.create!(name: "Dracaufeu", description:"l'ultime pokémon feu", start_date: Date.today, end_date: Date.today+1, user_id:1, first_price: 100)

Article.create!(name: "Carapuce", description:"une tortue bleue", start_date: Date.today, end_date: Date.today+1, user_id:1, first_price: 100)

Article.create!(name: "Bulbizarre", description:"une plante verte", start_date: Date.today, end_date: Date.today+1, user_id:1, first_price: 100)

Article.create!(name: "Salamèche", description:"un lézard rouge", start_date: Date.today, end_date: Date.today+1, user_id:1, first_price: 100)

Article.create!(name: "Rattata", description:"un rat violet", start_date: Date.today, end_date: Date.today+1, user_id:1, first_price: 100)
