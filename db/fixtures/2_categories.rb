category_attrs = proc do
  10.times.map do |idx|
    {
      id: idx + 1,
      name: Faker::Name.name
    }
  end
end

Category.seed_once(:id, *category_attrs.call)
