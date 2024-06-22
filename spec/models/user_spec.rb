# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    context 'すべての必須属性が存在する場合' do
      it '有効な状態であること' do
        expect(build(:user)).to be_valid
      end
    end

    context '必須属性が欠けている場合' do
      it { is_expected.to validate_presence_of :email }
      it { is_expected.to validate_presence_of :password }
      it { is_expected.to validate_presence_of :display_name }
      it { is_expected.to validate_presence_of :username }
      it { is_expected.to validate_presence_of :date_of_birth }
      it { is_expected.to validate_presence_of :mobile_number }
    end

    describe 'uidの一意性' do
      context '同じproviderの場合' do
        let!(:existing_user) { create(:user, :github, uid: 'test_uid') }

        it 'uidが異なれば有効な状態であること' do
          expect(build(:user, :github, uid: 'diff_uid')).to be_valid
        end

        it 'uidが重複したら無効な状態であること' do
          expect(build(:user, :github, uid: 'test_uid')).not_to be_valid
        end
      end

      context '異なるproviderの場合' do
        it 'uidが重複しても有効な状態であること' do
          create(:user, :github, uid: 'test_uid') 
          expect(build(:user, :google, uid: 'test_uid')).to be_valid
        end
      end
    end

    describe '文字数制限' do
      it { is_expected.to validate_length_of(:bio).is_at_most(160) }
      it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(128) }
    end

    context 'emailが重複する場合' do
      let!(:existing_user) { create(:user) }
      it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    end
  end
end
