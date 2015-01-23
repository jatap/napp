require 'rails_helper'

RSpec.describe UserSocialNetwork, type: :model do
  before do
    @user_social_network = build(:user_social_network)
    I18n.locale = :en
  end

  subject { @user_social_network }

  describe 'given expected attributes' do
    [:twitter,
     :facebook,
     :google_plus,
     :instagram,
     :youtube,
     :whatsup,
     :linkedin,
     :pinterest,
     :flickr,
     :digg,
     :reddit].each do |expected_attribute|
      it { expect(@user_social_network).to respond_to expected_attribute }
    end
  end

  describe 'given initial state' do
    it 'is valid' do
      expect(@user_social_network).to be_valid
    end
  end

  describe '#to_s' do
    it 'shows :twitter' do
      expect(@user_social_network.to_s).to eq @user_social_network.twitter
    end
  end
end
