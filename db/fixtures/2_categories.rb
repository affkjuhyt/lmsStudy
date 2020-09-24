category_name = ["Web Design", "Web Development", "Marketing", "Product Management"]

category_attrs = proc do
  4.times.map do |idx|
    {
      id: idx + 1,
      name: category_name.sample,
      image: Faker::LoremFlickr.image(size: '150x150')
    }
  end
end

Category.seed_once(:id, *category_attrs.call)
