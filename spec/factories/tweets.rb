FactoryBot.define do
  factory :tweet do
    content { 'Twitterを始めました!' }
    association :user

    after(:attributes_for) do |tweet|
      tweet.image.attach(io: File.open('spec/fixtures/mock_avatar.png'), filename: 'mock_avatar.png', content_type: 'image/png')
    end

    trait :invalid do
      content { nil }
    end
  end
end
