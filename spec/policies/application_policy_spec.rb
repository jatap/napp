require 'rails_helper'

describe ApplicationPolicy do
  context 'admin, editor and user roles policies' do
    let(:admin)  { create(:user_with_admin_role) }
    let(:editor) { create(:user_with_editor_role) }
    let(:user)   { create(:user_with_user_role) }

    subject { ApplicationPolicy }

    permissions :index?, :create?, :new?, :update?, :edit?, :destroy? do
      it 'denies access in all use cases' do
        expect(subject).not_to permit(admin, admin)
        expect(subject).not_to permit(user, user)
        expect(subject).not_to permit(editor, editor)
      end
    end

    permissions :show? do
      it 'grants access in all use cases' do
        expect(subject).to permit(admin, admin)
        expect(subject).to permit(user, user)
        expect(subject).to permit(editor, editor)
      end
    end

    context 'for and admin' do
      before :each do
        @admin  = create(:user_with_admin_role)
      end

      it 'should return all records' do
        policy = ApplicationPolicy::Scope.new(@admin, User.all).resolve
        policy.each do |p|
          expect(p.id).to eq(@admin.id)
        end
      end
    end
  end
end
