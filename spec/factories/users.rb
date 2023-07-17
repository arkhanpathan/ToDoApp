# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name  { 'india' }
    email { 'john@email.com' }
    password { 123_456 }
  end
end
