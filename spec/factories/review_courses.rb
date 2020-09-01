require "faker"

FactoryBot.define do
  factory :review_course do |r|
    r.comment { Faker::Lorem.sentence }
    association :user
    association :course
  end
end
