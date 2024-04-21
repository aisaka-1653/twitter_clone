# frozen_string_literal: true
require 'open-uri'
class User < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :header

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :timeoutable,
         :lockable, :omniauthable, omniauth_providers: %i[github]

  validates :email, :display_name, :username, :date_of_birth, :mobile_number, presence: true
  validates :uid, uniqueness: { scope: :provider }

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.display_name = auth.info.name
      user.username = auth.info.nickname
      attach_avatar_from_url(user, auth.info.image)
      # メアドによるアカウント登録では入力必須のためダミーデータを入れる
      user.date_of_birth = '1900-01-01'
      user.mobile_number = '00011112222'
      user.skip_confirmation!
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  private

  # 拡張子はContent-Typeヘッダーから取得するらしいが今回は実装しない
  def self.attach_avatar_from_url(user, url)
    filename = "user_#{user.uid}_avatar"
    user.avatar.attach(io: URI.open(url), filename: filename)
  end
end
