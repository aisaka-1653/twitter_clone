# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Sessions', type: :request do
  describe 'GET /users/sign_in' do
    context 'with unauthenticated user' do
      it 'displays the login page' do
        get new_user_session_path
        expect(response).to have_http_status :ok
        expect(response.body).to include('ログインを記憶する')
      end
    end

    context 'with authenticated user' do
      let(:user) { create(:user) }

      before { sign_in user }

      it 'redirects to the home page' do
        get new_user_session_path
        expect(response).to have_http_status :found
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eq 'すでにログインしています。'
      end
    end
  end

  describe 'POST /users/sign_in' do
    let(:user) { create(:user) }

    context 'with valid parameters' do
      let(:params) { { user: { email: user.email, password: user.password } } }

      it 'authenticates and redirects to the home page' do
        post(user_session_path, params:)
        expect(response).to have_http_status :see_other
        expect(response).to redirect_to root_path
        expect(flash[:notice]).to eq 'ログインしました。'
      end
    end

    context 'with invalid parameters' do
      let(:params) { { user: { email: user.email, password: 'wrong_password' } } }

      it 'fails to authenticate and displays an error message' do
        post(user_session_path, params:)
        expect(response).to have_http_status :unprocessable_entity
        expect(flash[:alert]).to eq 'Eメールまたはパスワードが違います。'
      end
    end
  end
end
