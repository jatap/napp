# == Schema Information
#
# Table name: sites
#
#  id          :integer          not null, primary key
#  name        :string
#  version     :string
#  author      :string
#  email       :string
#  twitter     :string
#  facebook    :string
#  linkedin    :string
#  google_plus :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_sites_on_name  (name) UNIQUE
#

require 'rails_helper'

RSpec.describe Site, type: :model do
  before :each do
    @site       = build(:site)
    I18n.locale = :en
  end

  subject { @site }

  describe 'given expected attributes' do
    [:name,
     :version,
     :author,
     :banner,
     :email,
     :twitter,
     :facebook,
     :linkedin,
     :google_plus].each do |expected_attribute|
      it { expect(@site).to respond_to expected_attribute }
    end
  end

  describe 'given initial state' do
    it 'is valid' do
      expect(@site).to be_valid
    end
  end

  describe '#to_s' do
    it 'shows :name' do
      expect(@site.to_s).to eq @site.name
    end
  end

  describe '#name' do
    context 'when empty' do
      before :each do
        @site.name = ''
      end

      it 'is invalid' do
        expect(@site).to be_invalid
      end
    end

    context 'when is already token' do
      let(:bad_site) { @site.dup }

      before :each do
        new_site       = create(:site)
        bad_site.name  = new_site.name
        bad_site.email = Faker::Internet.email
      end

      it 'is invalid' do
        expect(bad_site).to be_invalid
      end

      it 'has 1 error on name' do
        bad_site.save
        expect(bad_site.errors[:name]).to include('has already been taken')
      end
    end
  end

  describe '#banner' do
    context 'when empty' do
      before { @site.banner = '' }

      it 'is invalid' do
        expect(@site).to be_invalid
      end
    end
  end

  describe '#email' do
    context 'when empty' do
      before { @site.email = '' }

      it 'is invalid' do
        expect(@site).to be_invalid
      end
    end

    context 'when is not well formed' do
      before { @site.email = 'invalid@email' }

      it 'is invalid' do
        expect(@site).to be_invalid
      end
    end
  end

  describe '#twitter' do
    context 'when empty' do
      before { @site.twitter = '' }

      it 'is invalid' do
        expect(@site).to be_invalid
      end
    end

    context 'when is not well formed' do
      before { @site.twitter = 'twitter.com' }

      it 'is invalid' do
        expect(@site).to be_invalid
      end
    end
  end

  describe '#facebook' do
    context 'when empty' do
      before { @site.facebook = '' }

      it 'is invalid' do
        expect(@site).to be_invalid
      end
    end

    context 'when is not well formed' do
      before { @site.facebook = 'facebook.com' }

      it 'is invalid' do
        expect(@site).to be_invalid
      end
    end
  end

  describe '#linkedin' do
    context 'when empty' do
      before { @site.linkedin = '' }

      it 'is invalid' do
        expect(@site).to be_invalid
      end
    end

    context 'when is not well formed' do
      before { @site.linkedin = 'linkedin.com' }

      it 'is invalid' do
        expect(@site).to be_invalid
      end
    end
  end

  describe '#google_plus' do
    context 'when empty' do
      before { @site.google_plus = '' }

      it 'is invalid' do
        expect(@site).to be_invalid
      end
    end

    context 'when is not well formed' do
      before { @site.google_plus = 'google.com' }

      it 'is invalid' do
        expect(@site).to be_invalid
      end
    end
  end
end
