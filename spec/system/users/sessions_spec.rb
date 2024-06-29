# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Sessions', type: :system do
  describe 'User login' do
    before { visit root_path }

    context 'with valid parameters' do
      let(:user) { create(:user) }

      it 'logs in the user and redirects to the home page' do
        first('a', text: 'ログイン').click

        fill_in 'Eメール', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'

        expect(page).to have_current_path root_path, ignore_query: true
        expect(page).to have_content 'ログインしました。'
      end
    end

    context 'with invalid parameters' do
      it 'fails to log in and displays an error message' do
        first('a', text: 'ログイン').click

        fill_in 'Eメール', with: ''
        fill_in 'パスワード', with: ''
        click_button 'ログイン'

        expect(page).to have_current_path new_user_session_path, ignore_query: true
        expect(page).to have_content 'Eメールまたはパスワードが違います。'
      end
    end
  end
end
