require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  context 'with Users::SessionsController' do
    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user = create(:user_with_admin_role)
      I18n.locale = :en
    end

    describe '#after_sign_up_path_for' do
      it 'redirects to dashboard backend page' do
        get :new, locale: :en
        path = backend_dashboard_en_path
        expect(controller.after_sign_up_path_for(@user)).to eq path
      end
    end

    describe '#after_sign_out_path_for' do
      it 'redirects to home page' do
        get :new, locale: :en
        path = root_en_path
        expect(controller.after_sign_out_path_for(@user)).to eq path
      end
    end
  end
end
