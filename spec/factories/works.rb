FactoryBot.define do
  factory :work do
    shop_name            {"ああああ"}
    employment_status_id {"2"}
    work_name            {"ああああ"}
    work_text            {"ああああ"}
    phone                {"09012345678"}
    association :admin
  end
end
