# == Schema Information
#
# Table name: pictures
#
#  id                  :integer          not null, primary key
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  avatar_url          :string
#  user_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_pictures_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Picture, type: :model do
  before do
    @picture = build(:picture)
  end

  subject { @picture }

  describe 'given expected attributes' do
    [:avatar,
     :avatar_url].each do |expected_attribute|
      it { expect(@picture).to respond_to expected_attribute }
    end
  end

  describe 'given initial state' do
    it 'is valid' do
      expect(@picture).to be_valid
    end
  end

  describe '#to_s' do
    it 'shows :avatar_url' do
      expect(@picture.to_s).to eq @picture.avatar_url
    end
  end

  context '#avatar_url' do
    before :each do
      File.open('./app/assets/images/Box.png', 'r') do |file|
        @file           = file
        @picture.avatar = file
      end
    end

    it 'shows :avatar_url' do
      expect(@picture.avatar_url).to match @file.path.split('/').last
    end
  end
end
