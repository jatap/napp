require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  context 'GET#edit' do
    let(:user) { create(:user_with_admin_role) }

    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      I18n.locale = :en
      sign_in user
    end

    it 'assigns the requested user to @user' do
      get :edit, locale: :en, id: user
      expect(assigns(:user)).to eq user
    end

    it 'renders the :edit' do
      get :edit, id: user, locale: :en
      expect(response).to render_template :edit
    end
  end

  context 'PATCH#update' do
    before :each do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      I18n.locale = :en
      @user = create(:user_with_admin_role)
      sign_in @user
    end

    context 'valid attributes' do
      it 'locates the requested @user' do
        patch :update, locale: :en, id: @user,
                       user: attributes_for(:user_with_admin_role)
        expect(assigns(:user)).to eq(@user)
      end

      it "changes @user's attributes" do
        admin_user_attributes = @user.attributes
        patch :update, locale: :en, id: @user,
                       user: admin_user_attributes
        @user.reload
        expect(@user.fullname).to eq admin_user_attributes["fullname"]
      end

      it 'redirects to the updated user' do
        @user.fullname = 'Mister Bean'
        admin_user_attributes = @user.attributes
        admin_user_attributes[:current_password] = @user.password
        patch :update, locale: :en, id: @user,
                       user: admin_user_attributes
        expect(response).to redirect_to backend_dashboard_en_path
      end
    end

    describe 'with invalid attributes' do
      it "does not change the user's attributes" do
        fullname = @user.fullname
        patch :update, locale: :en, id: @user,
                       user: attributes_for(:user_with_admin_role,
                                            password: '',
                                            fullname: '')
        @user.reload
        expect(@user.fullname).to eq(fullname)
      end

      it 're-renders the :edit template' do
        patch :update, locale: :en, id: @user,
                       user: attributes_for(:user_with_admin_role, fullname: '')
        expect(response).to render_template :edit
      end
    end
  end

  describe 'POST#create' do
    context 'with valid attributes' do
      let(:admin_user) { attributes_for(:user_with_admin_role) }

      before :each do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        I18n.locale = :en
      end

      it 'saves the new user in the database' do
        expect do
          post :create, locale: :en, user: admin_user
        end.to change(User, :count).by(1)
      end

      it 'redirects to users#index' do
        post :create, locale: :en, user: admin_user
        expect(response).to redirect_to backend_dashboard_en_path
      end
    end

    context 'with invalid attributes' do
      let(:invalid_user) { attributes_for(:invalid_user) }

      before :each do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        I18n.locale = :en
      end

      it 'does not save the new user in the database' do
        expect do
          post :create, locale: :en, user: invalid_user
        end.not_to change(User, :count)
      end

      it 're-renders the :new template' do
        post :create, locale: :en, user: invalid_user
        expect(response).to render_template :new
      end
    end
  end
end
