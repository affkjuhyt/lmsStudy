require 'faker'

FactoryBot.define do
  factory :course do |r|
    r.user_id { 1 }
    r.title { Faker::Job.title }
    r.overview { Faker::Lorem.sentence(word_count: 15) }
    r.description { Faker::Lorem.sentence }
    r.image { Faker::LoremFlickr.image }
    association :user
  end
end
