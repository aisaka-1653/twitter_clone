# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
      # user.image = auth.info.image
      user.username = auth.info.nickname
      # メアドによるアカウント登録では入力必須のためダミーデータを入れる
      user.date_of_birth = '1900-01-01'
      user.mobile_number = '00011112222'
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end
end
