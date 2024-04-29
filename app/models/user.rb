# frozen_string_literal: true

require 'open-uri'
class User < ApplicationRecord
  before_create :set_uid
  after_create :set_default_avatar, :set_default_header

  has_many :tweets, dependent: :destroy
  has_many :followers, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy, inverse_of: :followee
  has_many :followees, class_name: 'Follow', foreign_key: 'followee_id', dependent: :destroy, inverse_of: :follower
  has_many :following_users, through: :followers, source: :followee
  has_many :follower_users, through: :followees, source: :follower

  has_many :likes
  has_many :retweets
  has_many :bookmarks
  has_many :comments

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

  # 拡張子はContent-Typeヘッダーから取得するらしいが今回は実装しない
  def self.attach_avatar_from_url(user, url)
    file = URI.parse(url).open
    filename = "user_#{user.uid}_avatar"
    user.avatar.attach(io: file, filename:)
  end

  private_class_method :attach_avatar_from_url

  private

  def set_uid
    return if provider == 'github'

    self.uid = create_unique_string
  end

  def create_unique_string
    SecureRandom.uuid
  end

  def set_default_avatar
    return if provider == 'github'

    avatar.attach(io: File.open(Rails.root.join('app/assets/images/users/default_avatar.png')),
                  filename: 'default_avatar.png', content_type: 'image/png')
  end

  def set_default_header
    header.attach(io: File.open(Rails.root.join('app/assets/images/users/default_header.png')),
                  filename: 'default_header.png', content_type: 'image/png')
  end

end
