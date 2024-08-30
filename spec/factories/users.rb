# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    pseudo { 'johndoe' }
    email { 'john.doe@example.com' }
    password { 'password' }
    role { 'user' }
  end
end
