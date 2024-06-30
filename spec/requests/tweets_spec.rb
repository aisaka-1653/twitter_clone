# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  describe 'POST /tweets' do
    let(:valid_params) { { tweet: attributes_for(:tweet, content: 'Twitterを始めました!') } }
    let(:invalid_params) { { tweet: attributes_for(:tweet, content: nil) } }

    context 'with authenticated user' do
      let(:user) { create(:user) }

      before { sign_in user }

      it 'successfully creates a new tweet with valid content' do
        expect { post tweets_path, params: valid_params }.to change(Tweet, :count).by(1)
        expect(response).to have_http_status :found
        expect(response).to redirect_to root_path
        follow_redirect!
        expect(response.body).to include('Twitterを始めました!')
      end

      it 'fails to create a tweet with invalid content and shows an error' do
        expect { post tweets_path, params: invalid_params }.not_to change(Tweet, :count)
        expect(response).to have_http_status :found
        expect(response).to redirect_to root_path
        expect(flash[:danger]).to eq '文字か画像のどちらかは入力必須です'
      end
    end

    context 'with unauthenticated user' do
      it 'prevents tweet creation and prompts for authentication' do
        expect { post tweets_path, params: valid_params }.not_to change(Tweet, :count)
        expect(response).to have_http_status :found
        expect(response).to redirect_to new_user_session_path
        expect(flash[:alert]).to eq 'ログインもしくはアカウント登録してください。'
      end
    end
  end

  describe 'GET /tweets/:id' do
    let(:tweet) { create(:tweet) }

    context 'with authenticated user' do
      before { sign_in tweet.user }

      it 'displays the requested tweet' do
        get tweet_path(tweet)
        expect(response).to have_http_status :ok
        expect(response.body).to include('返信をツイート')
      end
    end

    context 'with unauthenticated user' do
      it 'restricts access and prompts for authentication' do
        get tweet_path(tweet)
        expect(response).to have_http_status :found
        expect(response).to redirect_to new_user_session_path
        expect(flash[:alert]).to eq 'ログインもしくはアカウント登録してください。'
      end
    end
  end
end
