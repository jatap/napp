require 'rails_helper'

describe SitePolicy do
  context 'admin, editor and user roles policies' do
    let(:admin)  { create(:user_with_admin_role) }
    let(:editor) { create(:user_with_editor_role) }
    let(:user)   { create(:user_with_user_role) }

    subject { SitePolicy }

    permissions :show?, :edit?, :update? do
      it 'grants access if user is an admin' do
        expect(subject).to permit(admin)
      end

      it 'denies access if user is not admin' do
        expect(subject).not_to permit(user)
        expect(subject).not_to permit(editor)
      end
    end
  end

  context 'for and admin' do
    before :each do
      @admin = create(:user_with_admin_role)
      @site  = Site.first
    end

    it 'should return all records' do
      policy = SitePolicy::Scope.new(@admin, Site.all).resolve
      policy.each do |p|
        expect(p.id).to eq(@site.id)
      end
    end
  end
end
