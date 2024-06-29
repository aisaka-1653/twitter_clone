require 'rails_helper'

RSpec.describe "Users::OmniauthCallbacks", type: :request do
  describe "POST /users/auth/github/callback" do

    shared_examples 'successful authentication' do
      it 'ホーム画面にリダイレクトしてメッセージを表示すること' do
        post user_github_omniauth_callback_path
        expect(response).to have_http_status :found
        expect(response).to redirect_to root_path
        expect(flash[:notice]).to eq 'github アカウントによる認証に成功しました。'
      end
    end

    context '認証に成功した場合' do
      before {
        stub_request(:get, "http://example.com/mock_user_avatar.png")
          .to_return(status: 200, body: File.new("spec/fixtures/mock_avatar.png"), headers: {'Content-Type' => 'image/png'})
        mock_github_auth
      }

      context '初回ログインの場合' do
        it 'ユーザを作成してログインすること' do
          expect {
            post user_github_omniauth_callback_path
          }.to change(User, :count).by(1)
        end

        it_behaves_like 'successful authentication'
      end

      context '2回目以降のログインの場合' do
        before {
          post user_github_omniauth_callback_path
        }

        it 'ユーザを作成せずログインすること' do
          expect {
            post user_github_omniauth_callback_path
          }.to_not change(User, :count)
        end

        it_behaves_like 'successful authentication'
      end
    end

    context '認証に失敗した場合' do
      before { mock_github_auth_failure }

      it 'ログインに失敗しflashメッセージを表示すること' do
        post user_github_omniauth_callback_path
        expect(response).to redirect_to root_path
        follow_redirect!
        expect(flash[:alert]).to eq 'ログインもしくはアカウント登録してください。'
      end
    end
  end
end
