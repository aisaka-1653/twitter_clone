# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Registrations', type: :request do
  describe 'GET /users/sign_up' do
    context 'with unauthenticated user' do
      it 'displays the registration page' do
        get new_user_registration_path
        expect(response).to have_http_status :ok
        expect(response.body).to include('電話番号')
      end
    end

    context 'with authenticated user' do
      let(:user) { create(:user) }

      before { sign_in user }

      it 'redirects to the home page' do
        get new_user_registration_path
        expect(response).to have_http_status :found
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eq 'すでにログインしています。'
      end
    end
  end

  describe 'POST /users/sign_up' do
    context 'with valid parameters' do
      let(:params) { { user: attributes_for(:user) } }

      it 'registers user and confirms via email' do
        expect do
          perform_enqueued_jobs do
            post user_registration_path, params:
          end
        end.to change(User, :count).by(1)
                                   .and change { ActionMailer::Base.deliveries.count }.by(1)

        mail = ActionMailer::Base.deliveries.last
        expect(mail.to).to eq([params[:user][:email]])
        expect(mail.subject).to eq 'メールアドレス確認メール'
      end
    end

    context 'with invalid parameters' do
      let(:params) { { user: attributes_for(:user, email: nil) } }

      it 'does not create a user and displays validation errors' do
        expect do
          post user_registration_path, params:
        end.not_to change(User, :count)

        expect(response).to have_http_status :unprocessable_entity
        expect(response.body).to include('Eメールを入力してください')
      end
    end
  end
end
