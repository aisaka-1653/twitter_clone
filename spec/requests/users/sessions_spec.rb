require 'rails_helper'

RSpec.describe "Users::Sessions", type: :request do
  describe "GET /users/sign_in" do
    context 'ゲストユーザの場合' do
      it 'ログイン画面を表示すること' do
        get new_user_session_path
        expect(response).to have_http_status :ok
        expect(response.body).to include('ログインを記憶する')
      end
    end

    context 'ログインユーザの場合' do
      let(:user) { create(:user) }

      before { sign_in user }

      it 'ホーム画面にリダイレクトすること' do
        get new_user_session_path
        expect(response).to have_http_status :found
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eq 'すでにログインしています。'
      end
    end
  end

  describe "POST /users/sign_in" do
    let(:user) { create(:user) }

    context '有効なパラメータの場合' do
      let(:params) { { user: { email: user.email, password: user.password } } }

      it 'ログイン後､ホーム画面にリダイレクトすること' do
        post user_session_path, params: params
        expect(response).to have_http_status :see_other
        expect(response).to redirect_to root_path
        expect(flash[:notice]).to eq 'ログインしました。'
      end
    end

    context '無効なパラメータの場合' do
      let(:params) { { user: { email: user.email, password: 'wrong_password' } } }

      it 'ログインに失敗しflashメッセージを表示すること' do
        post user_session_path, params: params
        expect(response).to have_http_status :unprocessable_entity
        expect(flash[:alert]).to eq 'Eメールまたはパスワードが違います。'
      end
    end
  end
end
