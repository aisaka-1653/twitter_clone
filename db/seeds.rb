# frozen_string_literal: true

ApplicationRecord.transaction do
  (1..5).each do |n| 
    user = User.create!(
      email: "user#{n}@example.com",
      password: "123456",
      password_confirmation: "123456",
      display_name: "display_name#{n}",
      username: "username#{n}",
      date_of_birth: "1997-11-27",
      mobile_number: "00011112222",
    )
    user.tweets.create!(
      content: "Twitterを始めました｡#{user.display_name}です｡"
    )
  end
end

User.all.each do |user|
  next_user = User.find_by(id: user.id + 1)
  next_user = User.first if next_user.nil?
  Follow.create!(follower: user, followee: next_user)
end
