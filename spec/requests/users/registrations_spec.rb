require 'rails_helper'

RSpec.describe "Users::Registrations", type: :request do
  let(:user) { create(:user) }

  describe "GET /users/sign_up" do
    subject(:sign_up_page_request) { get new_user_registration_path }

    context 'ゲストユーザの場合' do
      before { sign_up_page_request }

      it '新規登録画面を表示すること' do
        expect(response).to have_http_status :ok
        expect(response.body).to include('電話番号')
      end
    end

    context 'ログインユーザの場合' do
      before do
        sign_in user
        sign_up_page_request
      end

      it 'ホーム画面にリダイレクトすること' do
        expect(response).to have_http_status :found
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eq "すでにログインしています。"
      end
    end
  end

  describe "POST /users/sign_up" do
    subject(:sign_up_request) { post user_registration_path, params: params }

    context '有効なパラメータの場合' do
      let(:params) { { user: attributes_for(:user) } }

      it 'ユーザを作成し､認証メールを送信すること' do
        expect { perform_enqueued_jobs { sign_up_request } }
          .to change(User, :count).by(1)
          .and change { ActionMailer::Base.deliveries.count }.by(1)

        mail = ActionMailer::Base.deliveries.last
        expect(mail.to).to eq([params[:user][:email]])
        expect(mail.subject).to eq 'メールアドレス確認メール'
      end
    end

    context '無効なパラメータの場合' do
      let(:params) { { user: attributes_for(:user, :invalid) } }

      it 'ユーザを作成せず､新規登録画面をレンダリングすること' do
        expect { sign_up_request }.to_not change(User, :count)
        expect(response).to have_http_status :unprocessable_entity
        expect(response.body).to include('電話番号')
      end
    end
  end
end
