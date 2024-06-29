# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  describe 'POST /tweets' do
    context 'ログインユーザの場合' do
      let(:user) { create(:user) }

      before { sign_in user }

      context '有効なパラメータの場合' do
        let(:params) { { tweet: attributes_for(:tweet, content: 'Twitterを始めました!') } }

        it 'ツイートしてホーム画面にリダイレクトすること' do
          expect {
            post tweets_path, params: params
          }.to change(Tweet, :count).by(1)

          expect(response).to have_http_status :found
          expect(response).to redirect_to root_path
          follow_redirect!
          expect(response.body).to include('Twitterを始めました!')
        end
      end

      context '無効なパラメータの場合' do
        let(:params) { { tweet: attributes_for(:tweet, content: nil) } }

        it 'ホーム画面にリダイレクトしてflashメッセージを表示すること' do
          expect do
            post tweets_path, params: params
          end.to_not change(Tweet, :count)

          expect(response).to have_http_status :found
          expect(response).to redirect_to root_path
          expect(flash[:danger]).to eq "文字か画像のどちらかは入力必須です"
        end
      end
    end

    context 'ゲストユーザの場合' do
      let(:params) { { tweet: attributes_for(:tweet) } }

      it 'ログイン画面にリダイレクトしてflashメッセージを表示すること' do
        expect do
          post tweets_path, params: params
        end.to_not change(Tweet, :count)

        expect(response).to have_http_status :found
        expect(response).to redirect_to new_user_session_path
        expect(flash[:alert]).to eq 'ログインもしくはアカウント登録してください。'
      end
    end
  end

  describe 'GET /tweets/:id' do
    context 'ログインユーザの場合' do
      let(:tweet) { create(:tweet) }

      before { sign_in tweet.user }

      it 'ツイート詳細画面を表示すること' do
        get tweet_path(tweet)
        expect(response).to have_http_status :ok
        expect(response.body).to include('返信をツイート')
      end
    end

    context 'ゲストユーザの場合' do
      let(:tweet) { create(:tweet) }

      it 'ログイン画面にリダイレクトしてflashメッセージを表示すること' do
        get tweet_path(tweet)
        expect(response).to have_http_status :found
        expect(response).to redirect_to new_user_session_path
        expect(flash[:alert]).to eq 'ログインもしくはアカウント登録してください。'
      end
    end
  end
end
