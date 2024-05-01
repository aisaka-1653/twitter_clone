# frozen_string_literal: true

ApplicationRecord.transaction do
  (1..5).each do |n|
    user = User.new(
      email: "user#{n}@example.com",
      password: '123456',
      password_confirmation: '123456',
      display_name: "display_name#{n}",
      username: "username#{n}",
      date_of_birth: '1997-11-27',
      mobile_number: '00011112222',
      bio: 'Webエンジニアに転職するため勉強中 #happinessChain 23.08.28〜',
      location: '大分',
      website: 'https://www.google.co.jp'
    )
    user.skip_confirmation!
    user.save!
    (1..10).each do |i|
      user.tweets.create!(
        content: "#{user.display_name}です｡#{i}回目のツイートです｡"
      )
    end
  end
end

ApplicationRecord.transaction do
  User.find_each do |user|
    User.where.not(id: user.id).find_each do |other_user|
      Follow.create!(follower: user, followee: other_user)
      other_user.tweets.limit(5).find_each do |tweet|
        user.likes.create!(tweet:)
        user.retweets.create!(tweet:)
        user.bookmarks.create!(tweet:)
        user.comments.create!(
          tweet:,
          content: "#{other_user.display_name}さん!はじめまして!",
          username: other_user.username
        )
      end
    end
  end
end

user = User.first
user.avatar.attach(
  io: File.open(Rails.root.join('app/assets/images/users/user1_avatar.jpg')),
  filename: 'user1_avatar.jpg',
  content_type: 'image/jpg'
)
user.header.attach(
  io: File.open(Rails.root.join('app/assets/images/users/user1_header.png')),
  filename: 'user1_header.png',
  content_type: 'image/png'
)
