require 'rails_helper'

RSpec.describe "Users::OmniatuhCallbacks", type: :system do
  describe 'GitHubログイン' do
    context '認証に成功した場合' do
      before do
        stub_request(:get, "http://example.com/mock_user_avatar.png")
          .to_return(status: 200, body: File.new("spec/fixtures/mock_avatar.png"), headers: {'Content-Type' => 'image/png'})
        mock_github_auth
      end

      it 'ユーザーを作成してログインすること' do
        visit root_path

        expect {
          click_button 'GitHubでログイン'
        }.to change(User, :count).by(1)

        expect(current_path).to eq root_path
        expect(page).to have_content 'github アカウントによる認証に成功しました。'
      end
    end

    context '認証に失敗した場合' do
      before { mock_github_auth_failure }

      it 'ユーザーを作成せずログイン画面にリダイレクトすること' do
        visit root_path

        expect {
          click_button 'GitHubでログイン'
        }.not_to change(User, :count)

        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'ログインを記憶する'
      end
    end
  end
end
