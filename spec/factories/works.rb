FactoryBot.define do
  factory :work do
    shop_name            {Faker::Name.initials}
    employment_status_id {"2"}
    work_name            {Faker::Name.initials}
    work_text            {Faker::Name.initials}
    phone                {"09012345678"}
    association :admin
  end
end
