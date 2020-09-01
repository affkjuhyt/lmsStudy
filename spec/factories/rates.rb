require "faker"

FactoryBot.define do
  factory :rate do |r|
    association :user
    association :course
  end
end
