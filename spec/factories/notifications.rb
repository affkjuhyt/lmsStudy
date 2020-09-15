FactoryBot.define do
  factory :notification do
    recipient_id { 1 }
    actor_id { 1 }
    read_at { "2020-09-16 13:21:50" }
    action { "MyString" }
    notifiable_id { 1 }
    notifiable_type { "MyString" }
  end
end
