require 'faker'

FactoryBot.define do
  factory :category do |r|
    r.name { Faker::Name.name }
    association :course
  end
end
