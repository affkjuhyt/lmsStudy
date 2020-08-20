user_attrs = proc do
  10.times.map do |idx|
    {
      id: idx + 1,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email(domain: 'example'),
      password: "password",
      password_confirmation: "password",
      confirmed_at: Time.zone.now
    }
  end
end

User.seed_once(:id, *user_attrs.call)
