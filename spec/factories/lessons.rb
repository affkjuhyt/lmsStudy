require 'faker'

FactoryBot.define do
  factory :lesson do |r|
    r.course_id { 1 }
    r.name { Faker::Educator.course_name }
    r.lesson_type { rand(1..2) }
    association :course
  end
end
