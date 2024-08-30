# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    name { "Titre de l'article" }
    description { "Description de l'article" }
    first_price { 100.0 }
    start_date { DateTime.now + 1.day }
    end_date { DateTime.now + 2.days }
    category { 'Pokémon Combat' }
    association :user, factory: :user
  end
end
