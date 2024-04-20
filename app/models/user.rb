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
end
