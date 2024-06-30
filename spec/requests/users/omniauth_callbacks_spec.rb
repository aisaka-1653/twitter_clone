# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::OmniauthCallbacks', type: :request do
  describe 'POST /users/auth/github/callback' do
    shared_examples 'successful authentication' do
      it 'redirects to the home page with a success message' do
        post user_github_omniauth_callback_path
        expect(response).to have_http_status :found
        expect(response).to redirect_to root_path
        expect(flash[:notice]).to eq 'github アカウントによる認証に成功しました。'
      end
    end

    context 'with successful authentication' do
      before do
        stub_request(:get, 'http://example.com/mock_user_avatar.png')
          .to_return(
            status: 200,
            body: File.new('spec/fixtures/mock_avatar.png'),
            headers: { 'Content-Type' => 'image/png' }
          )
        mock_github_auth
      end

      it 'creates a new user on first login' do
        expect { post user_github_omniauth_callback_path }.to change(User, :count).by(1)
      end

      it 'does not create a new user on subsequent logins' do
        post user_github_omniauth_callback_path
        expect { post user_github_omniauth_callback_path }.not_to change(User, :count)
      end

      it_behaves_like 'successful authentication'
    end

    context 'with failed authentication' do
      before { mock_github_auth_failure }

      it 'redirects to the home page with an error message' do
        post user_github_omniauth_callback_path
        expect(response).to redirect_to root_path
        follow_redirect!
        expect(flash[:alert]).to eq 'ログインもしくはアカウント登録してください。'
      end
    end
  end
end
