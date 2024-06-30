# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::OmniatuhCallbacks', type: :system do
  describe 'GitHub login' do
    context 'with successful authentication' do
      before do
        stub_request(:get, 'http://example.com/mock_user_avatar.png')
          .to_return(
            status: 200,
            body: File.new('spec/fixtures/mock_avatar.png'),
            headers: { 'Content-Type' => 'image/png' }
          )
        mock_github_auth
        visit root_path
      end

      it 'creates a new user and logs them in' do
        expect { click_button 'GitHubでログイン' }.to change(User, :count).by(1)
        expect(page).to have_current_path root_path, ignore_query: true
        expect(page).to have_content 'github アカウントによる認証に成功しました。'
      end
    end

    context 'with failed authentication' do
      before do
        mock_github_auth_failure
        visit root_path
      end

      it 'does not create a user and redirects to the login page' do
        expect { click_button 'GitHubでログイン' }.not_to change(User, :count)
        expect(page).to have_current_path new_user_session_path, ignore_query: true
        expect(page).to have_content 'ログインを記憶する'
      end
    end
  end
end
