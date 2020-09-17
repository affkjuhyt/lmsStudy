category_attrs = proc do
  10.times.map do |idx|
    {
      id: idx + 1,
      name: Faker::Job.title,
      image: Faker::LoremFlickr.image(size: '150x150')
    }
  end
end

Category.seed_once(:id, *category_attrs.call)
