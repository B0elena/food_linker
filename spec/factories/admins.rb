FactoryBot.define do
  factory :admin do
    l_name                {Faker::Name.initials}
    f_name                {Faker::Name.initials}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password}
    password_confirmation {password}
  end
end
