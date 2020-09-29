FactoryBot.define do
  factory :user do
    nickname              {"ああああああ"}
    email                 {"kkk@gmail.com"}
    password              {"1234abcd"}
    password_confirmation {password}
  end
end