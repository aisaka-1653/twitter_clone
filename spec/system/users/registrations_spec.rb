# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Registrations', type: :system do
  describe 'User registration' do
    before { visit root_path }

    context 'with valid parameters' do
      it 'registers a new user and sends a confirmation email' do
        first('a', text: 'アカウント登録').click

        perform_enqueued_jobs do
          expect do
            fill_in 'Eメール', with: 'test@exapmle.com'
            fill_in 'パスワード', with: 'test123'
            fill_in 'パスワード（確認用）', with: 'test123'
            fill_in '表示名', with: 'Test'
            fill_in 'ユーザー名', with: 'test_123'
            fill_in '生年月日', with: '1997-11-27'
            fill_in '電話番号', with: '00011112222'
            click_button 'アカウント登録'
          end.to change(User, :count).by(1)

          expect(page).to have_current_path new_user_session_path, ignore_query: true
        end

        mail = ActionMailer::Base.deliveries.last

        aggregate_failures do
          expect(mail.to).to eq ['test@exapmle.com']
          expect(mail.from).to eq ['please-change-me-at-config-initializers-devise@example.com']
          expect(mail.subject).to eq 'メールアドレス確認メール'
          expect(mail.body).to match 'Confirm my account'
          expect(mail.body).to match 'test@exapmle.com'
        end
      end
    end

    context 'with invalid parameters' do
      it 'fails to register and displays validation messages' do
        first('a', text: 'アカウント登録').click

        expect do
          fill_in 'Eメール', with: ''
          fill_in 'パスワード', with: ''
          fill_in 'パスワード（確認用）', with: ''
          fill_in '表示名', with: ''
          fill_in 'ユーザー名', with: ''
          fill_in '生年月日', with: ''
          fill_in '電話番号', with: ''
          click_button 'アカウント登録'
        end.to change(User, :count).by(0)
                                   .and change { ActionMailer::Base.deliveries.count }.by(0)

        aggregate_failures do
          expect(page).to have_content 'Eメールを入力してください'
          expect(page).to have_content 'パスワードを入力してください'
          expect(page).to have_content '表示名を入力してください'
          expect(page).to have_content 'ユーザー名を入力してください'
          expect(page).to have_content '生年月日を入力してください'
          expect(page).to have_content '電話番号を入力してください'
        end
      end
    end
  end
end
