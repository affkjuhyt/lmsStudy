require "faker"

FactoryBot.define do
  factory :user do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.email { Faker::Internet.email(domain: 'example') }
    f.password { "password" }
    f.password_confirmation { "password" }
    f.confirmed_at { Time.zone.now }
    f.is_admin { false }
    f.created_at { Faker::Date.between(from: '2020-09-01', to: Time.zone.now) }
  end
end
