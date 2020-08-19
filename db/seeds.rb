# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user_ids = []
course_ids = []

20.times do |n|
  user = User.create!(
    first_name: Faker::Name.middle_name.delete("',^"),
    last_name: Faker::Name.middle_name.delete("',^"),
    email: "example_#{n+1}@gmail.com",
    password:  "password",
    password_confirmation: "password",
    confirmed_at: Time.zone.now,
    created_at: Faker::Date.between(from: '2020-08-19', to: Time.zone.now)
  )
  user_ids<<user.id
end

20.times do |n|
  course = Course.create!(
    user_id: 1,
    course_title: Faker::Lorem.sentence(word_count: 5),
    course_overview: Faker::Lorem.sentence(word_count: 15),
    course_description: Faker::Lorem.sentence(word_count: 40),
    course_image: Faker::Avatar.image
  )
  course_ids<<course.id
end
