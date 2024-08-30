# frozen_string_literal: true

FactoryBot.define do
  factory :bid do
    bid_price { 100.0 }
    association :article
    association :user
  end
end
