# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:display_name) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:date_of_birth) }
    it { is_expected.to validate_presence_of(:mobile_number) }

    it { is_expected.to validate_length_of(:bio).is_at_most(160) }
    it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(128) }

    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider).ignoring_case_sensitivity }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end
end
