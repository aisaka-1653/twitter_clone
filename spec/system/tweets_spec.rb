require 'rails_helper'

RSpec.describe "Tweets", type: :system do
  describe 'ツイート' do
    let(:user) { create(:user) }

    before { sign_in user }

    context '有効なパラメータの場合' do
      it 'ツイートが投稿されホーム画面にリダイレクトすること' do
        visit root_path

        expect {
          fill_in 'tweet_content', with: 'テストツイート'
          click_button 'ツイートする'
        }.to change(Tweet, :count).by(1)

        expect(current_path).to eq root_path
        expect(page).to have_content user.username
        expect(page).to have_content 'テストツイート'
      end
    end

    context '無効なパラメータの場合' do
      it 'ホーム画面にリダイレクトしてflashメッセージを表示すること' do
        visit root_path

        expect {
          fill_in 'tweet_content', with: ''
          click_button 'ツイートする'
        }.not_to change(Tweet, :count)

        expect(current_path).to eq root_path
        expect(page).to have_content '文字か画像のどちらかは入力必須です'
      end
    end
  end
end
