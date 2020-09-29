FactoryBot.define do
  factory :admin do
    l_name                {"あああ"}
    f_name                {"あああ"}
    email                 {"kkk@gmail.com"}
    password              {"1234abcd"}
    password_confirmation {password}
  end
end
