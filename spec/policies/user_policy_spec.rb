require 'rails_helper'

describe UserPolicy do
  context 'admin, editor and user roles policies' do
    let(:admin)  { create(:user_with_admin_role) }
    let(:editor) { create(:user_with_editor_role) }
    let(:user)   { create(:user_with_user_role) }

    subject { UserPolicy }

    permissions :show?, :edit?, :update? do
      it 'grants access if user is an admin or owner' do
        expect(subject).to permit(admin, admin)
        expect(subject).to permit(editor, editor)
        expect(subject).to permit(user, user)
      end

      it 'denies access if user is not admin or owner' do
        expect(subject).not_to permit(user, admin)
        expect(subject).not_to permit(user, editor)
        expect(subject).not_to permit(editor, admin)
        expect(subject).not_to permit(editor, user)
      end
    end

    permissions :destroy?, :new?, :create?, :index? do
      it 'grants access if user is an admin' do
        expect(subject).to permit(admin, admin)
      end

      it 'denies access if user is not admin' do
        expect(subject).not_to permit(user, user)
        expect(subject).not_to permit(editor, editor)
      end
    end
  end

  context 'for and admin' do
    before :each do
      @admin  = create(:user_with_admin_role)
    end

    it 'should return all records' do
      policy = UserPolicy::Scope.new(@admin, User.all).resolve
      policy.each do |p|
        expect(p.id).to eq(@admin.id)
      end
    end
  end
end
