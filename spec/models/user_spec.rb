require 'spec_helper'

describe User do
  before do
    @user       = build(:user_with_editor_role)
    I18n.locale = :en
  end

  subject { @user }

  describe 'given expected attributes' do
    [:fullname,
     :email,
     :password,
     :password_confirmation,
     :roles].each do |expected_attribute|
      it { expect(@user).to respond_to expected_attribute }
    end
  end

  describe 'given initial state' do
    it 'is valid' do
      expect(@user).to be_valid
    end
  end

  describe '.fullname' do
    context 'when empty' do
      before { @user.fullname = '' }

      it 'is invalid' do
        expect(@user).to be_invalid
      end
    end

    context 'when is already token' do
      let(:bad_user) { @user.dup }

      before :each do
        @user.save
        bad_user.fullname = @user.fullname
        bad_user.email    = Faker::Internet.email
      end

      it 'is invalid' do
        expect(bad_user).to be_invalid
      end

      it 'has 1 error on fullname' do
        bad_user.fullname = ''
        bad_user.save
        expect(bad_user.errors[:fullname]).to include("can't be blank")
      end
    end
  end

  describe '.email' do
    context 'when empty' do
      before { @user.email = '' }

      it 'is invalid' do
        expect(@user).to be_invalid
      end
    end

    context 'when is already token' do
      let(:bad_user) { @user.dup }

      before :each do
        @user.save
        bad_user.email = @user.email
      end

      it 'is invalid' do
        expect(bad_user).to be_invalid
      end

      it 'has 1 error on email' do
        bad_user.email = ''
        bad_user.save
        expect(bad_user.errors[:email]).to include("can't be blank")
      end
    end
  end

  context '.role' do
    before :each do
      @user.roles.destroy_all
      @user.save
    end

    describe 'when empty' do
      it 'has :user role by default' do
        expect(@user).to have_role :user
      end
    end

    describe 'given one element' do
      it 'is valid' do
        expect(@user).to be_valid
      end

      it 'adds :user role afterwards this element is deleted and roles are empty' do
        expect(@user.roles.first.to_s).to eq 'user'
      end

      context 'when user object is updated and roles are empty' do
        let(:roles) { [create(:role, name: :user)] }

        before :each do
          @user.roles.destroy_all
          @user.update_attributes(fullname: @user.fullname + '!')
        end

        it 'adds :user role' do
          expect(@user.roles.last.to_s).to eq 'user'
        end
      end
    end
  end

  context '.editor?' do
    before :each do
      @user.add_role :editor
    end

    it 'checks if role :editor is added' do
      expect(@user.editor?).to eq true
    end
  end

  context '.user?' do
    before :each do
      @user.add_role :user
    end

    it 'checks if role :user is added' do
      expect(@user.user?).to eq true
    end
  end

  context '.admin?' do
    before :each do
      @user.add_role :admin
    end

    it 'checks if role :admin is added' do
      expect(@user.admin?).to eq true
    end
  end

  describe '.to_s' do
    it 'shows :fullname' do
      expect(@user.to_s).to eq @user.fullname
    end
  end

  describe '.update_with_password' do
    context 'when user has valid password' do
      let(:old_fullname) { @user.fullname }
      let(:new_fullname) { @user.fullname + 'test' }

      before :each do
        @user.fullname = new_fullname
      end

      it 'saves data' do
        @user.update_with_password({})
        expect(@user.fullname).to eq new_fullname
      end
    end

    context 'when user does not has valid password' do
      before :each do
        @user.password = @user.password_confirmation = @user.encrypted_password = nil
      end

      it 'does not save record' do
        expect(@user.update_with_password({})).to eq(false)
      end
    end
  end
end

