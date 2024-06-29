require 'rails_helper'

RSpec.describe "Users::Sessions", type: :system do
  describe 'ユーザー登録' do
    context '有効なパラメータの場合' do
      let(:user) { create(:user) }

      it 'ログイン後､ホーム画面にリダイレクトすること' do
        visit root_path
        first('a', text: 'ログイン').click

        fill_in 'Eメール', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'

        expect(current_path).to eq root_path
        expect(page).to have_content 'ログインしました。'
      end
    end

    context '無効なパラメータの場合' do
      it 'ログインに失敗してバリデーションメッセージを表示すること' do
        visit root_path
        first('a', text: 'ログイン').click

        fill_in 'Eメール', with: ''
        fill_in 'パスワード', with: ''
        click_button 'ログイン'

        expect(current_path).to eq new_user_session_path
        expect(page).to have_content 'Eメールまたはパスワードが違います。'
      end
    end
  end
end
