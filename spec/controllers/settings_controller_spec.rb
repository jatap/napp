require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  context 'GET#index' do
    let(:setting) { Setting.admin_mail }

    before :each do
      sign_in create(:user_with_user_role)
      get :index, locale: :en
    end

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end

  describe 'PATCH #update_all' do
    context 'with valid params' do
      let (:settings) { Setting.get_all }

      before :each do
        I18n.locale = :en
        @user = create(:user_with_user_role)
        sign_in @user
      end

      it 'updates the settings' do
        Setting.voila = 'touche'
        patch :update_all, locale: :en, update_all_settings: { admin_mail: 'new_mail@example.com' }
        expect(settings[:admin_mail]).to eq 'new_mail@example.com'
      end

      it 'redirects to the all setting page' do
        patch :update_all, locale: :en, update_all_settings: { admin_mail: 'new_mail@example.com' }
        expect(response).to redirect_to('/en/backend/settings')
      end
    end

    context 'with invalid params' do
      let (:settings) { {} }

      before :each do
        I18n.locale = :en
        @user = create(:user_with_user_role)
        sign_in @user
      end

      it 'does not update settings' do
        patch :update_all, locale: :en, update_all_settings: { }
        expect(assigns(:setting)).to be_nil
      end

      it 're-renders the show template' do
        patch :update_all, locale: :en, update_all_settings: { }
        expect(response).to redirect_to('/en/backend/settings')
      end
    end
  end
end
