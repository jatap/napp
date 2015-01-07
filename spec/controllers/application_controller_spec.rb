require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  context '#after_sign_in_path_for' do
    before :each do
      @user = create(:user_with_admin_role)
      I18n.locale = :en
    end

    it 'redirects to dashboard backend page' do
      sign_in @user
      path = backend_dashboard_en_path
      expect(controller.after_sign_in_path_for(@user)).to eq path
    end
  end

  describe '#default_url_options' do
    it 'set locale param if equal to default locale' do
      I18n.locale  = :es
      user         = create(:user_with_admin_role)
      sign_in user
      path         = root_path
      expect(response.request.env["rack.session.options"][:path]).to eq path
    end
  end
end
