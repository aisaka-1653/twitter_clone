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
      mobile_number: '00011112222'
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
        user.likes.create!(tweet: tweet)
        user.retweets.create!(tweet: tweet)
        user.bookmarks.create!(tweet: tweet)
        user.comments.create!(
          tweet: tweet,
          content: "#{other_user.display_name}さん!はじめまして!",
          username: other_user.username
        )
      end
    end
  end
end
