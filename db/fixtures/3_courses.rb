video_urls = ["https://player.vimeo.com/video/180293809", "https://player.vimeo.com/video/119105386",
  "https://player.vimeo.com/video/69225705", "https://player.vimeo.com/video/61789173",
  "https://player.vimeo.com/video/393999309", "https://player.vimeo.com/video/377600390",
  "https://player.vimeo.com/video/375432709", "https://player.vimeo.com/video/373997050",
  "https://player.vimeo.com/video/372988843", "https://player.vimeo.com/video/368134723",
  "https://player.vimeo.com/video/363921958", "https://player.vimeo.com/video/360832524",
  "https://player.vimeo.com/video/355204808", "https://player.vimeo.com/video/355114615",
  "https://player.vimeo.com/video/348671806", "https://player.vimeo.com/video/45230972",
  "https://player.vimeo.com/video/25641459", "https://player.vimeo.com/video/1904672",
  "https://player.vimeo.com/video/17752439", "https://player.vimeo.com/video/369095"]

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

lesson_attrs = proc do
  10.times.map do |idx|
    {
      course_id: idx+1,
      name: Faker::Educator.course_name,
      lesson_type: rand(1..2),
      sequence: idx +1,
      video_url: video_urls.sample
    }
  end
end

Course.seed_once(:id, *course_attrs.call)
Lesson.seed_once(:id, *lesson_attrs.call)
