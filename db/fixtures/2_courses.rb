course_attrs = proc do
  10.times.map do |idx|
    {
      id: idx + 1,
      user_id: 1,
      title: Faker::Lorem.sentence(word_count: 5),
      overview: Faker::Lorem.sentence(word_count: 15),
      description: Faker::Lorem.sentence(word_count: 40),
      image: Faker::Avatar.image
    }
  end
end

Course.seed_once(:id, *course_attrs.call)
