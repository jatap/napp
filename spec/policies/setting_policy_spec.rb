require 'rails_helper'

describe SettingPolicy do
  context 'admin, editor and user roles policies' do
    let(:admin)  { create(:user_with_admin_role) }
    let(:editor) { create(:user_with_editor_role) }
    let(:user)   { create(:user_with_user_role) }

    subject { SettingPolicy }

    permissions :index?, :update_all? do
      it 'grants access if user is an admin, editor or user' do
        expect(subject).to permit(admin, Setting.new)
        expect(subject).to permit(editor, Setting.new)
        expect(subject).to permit(user, Setting.new)
      end
    end
  end

  context 'for and user' do
    before :each do
      @user    = create(:user_with_user_role)
      Setting.admin_mail = 'wow@jatap.com'
      @setting = Setting.first
    end

    it 'should return all records' do
      policy = SettingPolicy::Scope.new(@user, Setting.all).resolve
      policy.each do |p|
        expect(p.id).to eq(@setting.id)
      end
    end
  end
end
