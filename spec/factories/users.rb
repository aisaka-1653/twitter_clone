FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    display_name { Faker::Name.name }
    username { Faker::Internet.username }
    date_of_birth { Faker::Date.birthday }
    mobile_number { Faker::PhoneNumber.cell_phone }
    bio { 'Webエンジニアに転職するため勉強中 #happinessChain 23.08.28〜' }
    location { Faker::Address.state }
    website { 'https://www.google.co.jp' }
    uid { Faker::Internet.uuid }
    confirmed_at { Date.today }

    trait :github do
      provider { 'github' }
    end

    trait :google do
      provider { 'google' }
    end
  end
end
