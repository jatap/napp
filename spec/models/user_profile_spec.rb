require 'rails_helper'

RSpec.describe UserProfile, type: :model do
  before do
    @user_profile = build(:user_profile)
    I18n.locale = :en
  end

  subject { @user_profile }

  describe 'given expected attributes' do
    [:first_name,
     :last_name,
     :website,
     :phone].each do |expected_attribute|
      it { expect(@user_profile).to respond_to expected_attribute }
    end
  end

  describe 'given initial state' do
    it 'is valid' do
      expect(@user_profile).to be_valid
    end
  end

  describe '#to_s' do
    it 'shows :first_name and :last_name' do
      expect(@user_profile.to_s).to eq [@user_profile.first_name,
                                        @user_profile.last_name].join(' ')
    end
  end
end
