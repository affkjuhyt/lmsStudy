require "faker"

FactoryBot.define do
  factory :user_course do |r|
    r.lesson_step { rand(1..18) }
    association :user
    association :course
  end
end
