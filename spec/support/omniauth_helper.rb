# frozen_string_literal: true

module OmniauthHelper
  def mock_github_auth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
                                                                  provider: 'github',
                                                                  uid: '123545',
                                                                  info: {
                                                                    email: 'mock@example.com',
                                                                    name: 'Mock User',
                                                                    nickname: 'mockuser',
                                                                    image: 'http://example.com/mock_user_avatar.png'
                                                                  },
                                                                  credentials: {
                                                                    token: 'mock_token',
                                                                    secret: 'mock_secret'
                                                                  }
                                                                })
  end

  def mock_github_auth_failure
    OmniAuth.config.mock_auth[:github] = :invalid_credentails
  end
end
