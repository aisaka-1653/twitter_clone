require 'rails_helper'

RSpec.describe "Users::Sessions", type: :request do
  let(:user) { create(:user) }

  describe "GET /users/sign_in" do
    subject(:login_page_request) { get new_user_session_path }

    context 'ゲストユーザの場合' do
      before { login_page_request }

      it 'ログイン画面を表示すること' do
        expect(response).to have_http_status :ok
        expect(response.body).to include('ログインを記憶する')
      end
    end

    context 'ログインユーザの場合' do
      before do
        sign_in user
        login_page_request
      end

      it 'ホーム画面にリダイレクトすること' do
        expect(response).to have_http_status :found
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eq 'すでにログインしています。'
      end
    end
  end

  describe "POST /users/sign_in" do
    subject(:login_request) { post user_session_path, params: params }

    context '有効なパラメータの場合' do
      let(:params) { { user: { email: user.email, password: user.password } } }

      it 'ログイン後､ホーム画面にリダイレクトすること' do
        login_request
        expect(response).to have_http_status :see_other
        expect(response).to redirect_to root_path
        expect(flash[:notice]).to eq 'ログインしました。'
      end
    end

    context '無効なパラメータの場合' do
      let(:params) { { user: { email: user.email, password: 'wrong_password' } } }

      it 'ログイン画面をレンダリングすること' do
        login_request
        expect(response).to have_http_status :unprocessable_entity
        expect(response.body).to include('ログインを記憶する')
      end
    end
  end
end
