FactoryBot.define do
  factory :tweet do
    tweet_name    { Faker::Lorem.sentence }
    tweet_text    { Faker::Lorem.sentence }
    association :admin
    after(:build) do |tweet|
      tweet.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
