# == Schema Information
#
# Table name: user_social_networks
#
#  id          :integer          not null, primary key
#  twitter     :string
#  facebook    :string
#  google_plus :string
#  instagram   :string
#  youtube     :string
#  whatsup     :string
#  linkedin    :string
#  pinterest   :string
#  flickr      :string
#  digg        :string
#  reddit      :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_user_social_networks_on_user_id  (user_id)
#

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
