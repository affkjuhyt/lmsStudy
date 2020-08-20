user_attrs = proc do
  10.times.map do |idx|
    {
      id: idx + 1,
      first_name: Faker::Name.middle_name.delete("',^"),
      last_name: Faker::Name.middle_name.delete("',^"),
      email: "example_#{idx+1}@gmail.com",
      password: "password",
      password_confirmation: "password",
      confirmed_at: Time.zone.now
    }
  end
end

User.seed_once(:id, *user_attrs.call)
