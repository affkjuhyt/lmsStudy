course_attrs = proc do
  10.times.map do |idx|
    {
      id: idx + 1,
      user_id: 1,
      title: Faker::Job.title,
      overview: Faker::Lorem.sentence(word_count: 15),
      description: Faker::Lorem.sentence,
      image: Faker::LoremFlickr.image
    }
  end
end

Course.seed_once(:id, *course_attrs.call)
