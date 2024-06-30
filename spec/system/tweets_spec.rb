# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :system do
  describe 'Tweet' do
    let(:user) { create(:user) }

    before do
      sign_in user
      visit root_path
    end

    context 'with valid parameters' do
      it 'creates a new tweet and displays it on the home page' do
        expect do
          fill_in 'tweet_content', with: 'テストツイート'
          click_button 'ツイートする'
        end.to change(Tweet, :count).by(1)

        expect(page).to have_current_path root_path, ignore_query: true
        expect(page).to have_content user.username
        expect(page).to have_content 'テストツイート'
      end
    end

    context 'with invalid parameters' do
      it 'does not create a tweet and displays an error message' do
        expect do
          fill_in 'tweet_content', with: ''
          click_button 'ツイートする'
        end.not_to change(Tweet, :count)

        expect(page).to have_current_path root_path, ignore_query: true
        expect(page).to have_content '文字か画像のどちらかは入力必須です'
      end
    end
  end
end
