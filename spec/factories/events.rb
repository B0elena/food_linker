FactoryBot.define do
  factory :event do
    event_name { Faker::Lorem.sentence }
    event_text { Faker::Lorem.sentence }
    prefecture {"東京都"}
    city       {"港区"}
    block      {"青山1-1-1"}
    date       {"2020-01-01-10-00"}
    phone      {"09012345678"}
    association :admin
  end
end
