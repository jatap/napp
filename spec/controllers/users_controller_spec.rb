require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'GET #show' do
    let(:user) { create(:user_with_admin_role) }

    before :each do
      sign_in user
    end

    it 'assigns the requested user to @user' do
      get :show, id: user, locale: :en
      expect(assigns(:user)).to eq user
    end

    it 'renders the :show template' do
      get :show, id: user, locale: :en
      expect(response).to render_template :show
    end
  end

  context 'GET #new' do
    let(:user) { create(:user_with_admin_role) }

    before :each do
      sign_in user
    end

    it 'assigns a new User to @user' do
      get :new, locale: :en
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the :new template' do
      get :new, locale: :en
      expect(response).to render_template :new
    end
  end

  context 'GET#index', js: true do
    let(:user) { create(:user_with_admin_role) }

    before :each do
      sign_in user
    end

    it 'renders the :index template' do
      get :index, locale: :en
      expect(response).to render_template :index
    end
  end

  describe 'GET#edit' do
    let(:user) { create(:user_with_admin_role) }

    before :each do
      sign_in user
    end

    it 'assigns the requested user to @user' do
      get :edit, id: user, locale: :en
      expect(assigns(:user)).to eq user
    end

    it 'renders the :edit' do
      get :edit, id: user, locale: :en
      expect(response).to render_template :edit
    end
  end

  describe 'POST#create' do
    context 'with valid attributes' do
      let(:admin_user) { create(:user_with_admin_role) }

      before :each do
        sign_in admin_user
      end

      it 'saves the new user in the database' do
        expect do
          post :create, locale: :en, user: attributes_for(:user_with_user_role)
        end.to change(User, :count).by(1)
      end

      it 'redirects to users#index' do
        post :create, locale: :en, user: attributes_for(:user_with_user_role)
        expect(response).to redirect_to users_en_path
      end
    end

    context 'with invalid attributes' do
      let(:admin_user) { create(:user_with_admin_role) }
      let(:invalid_user) { attributes_for(:invalid_user) }

      before :each do
        sign_in admin_user
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

  context 'PATCH#update' do
    before :each do
      @admin_user = create(:user_with_admin_role)
      sign_in @admin_user
    end

    context 'valid attributes' do
      it 'locates the requested @user' do
        patch :update, locale: :en, id: @admin_user,
                       user: attributes_for(:user_with_admin_role)
        expect(assigns(:user)).to eq(@admin_user)
      end

      it "changes @user's attributes" do
        patch :update, locale: :en, id: @admin_user,
                       user: attributes_for(:user_with_admin_role,
                                            fullname: 'Mister Bean')
        @admin_user.reload
        expect(@admin_user.fullname).to eq('Mister Bean')
      end

      it 'redirects to the updated user' do
        patch :update, locale: :en, id: @admin_user,
                       user: attributes_for(:user_with_admin_role)
        expect(response).to redirect_to user_en_path
      end

      context 'with picture' do
        let(:picture_param) { { picture_attributes: { avatar: '', avatar_url: '' } } }
        let(:remove_picture_param) { { remove_picture: '1' } }

        it 'deletes picture param when it comes empty' do
          patch :update,
                locale: :en,
                id: @admin_user,
                user: attributes_for(:user_with_admin_role).merge(picture_param)
          expect(@admin_user.picture).to be_nil
        end

        it 'removes picture param when remove image checkbox is checked' do
          patch :update,
                locale: :en,
                id: @admin_user,
                user: attributes_for(:user_with_admin_role)
                  .merge(picture_param)
                  .merge(remove_picture_param)
          expect(@admin_user.picture).to be_nil
        end

        it 'removes picture when remove image checkbox is checked' do
          patch :update,
                locale: :en,
                id: @admin_user,
                user: attributes_for(:user_with_admin_role).merge(picture_param)
          expect(@admin_user.picture).to be_nil
        end
      end
    end

    describe 'with invalid attributes' do
      it "does not change the user's attributes" do
        fullname = @admin_user.fullname
        patch :update, locale: :en, id: @admin_user,
                       user: attributes_for(:user_with_admin_role,
                                            password: '',
                                            fullname: '')
        @admin_user.reload
        expect(@admin_user.fullname).to eq(fullname)
      end

      it 're-renders the :edit template' do
        patch :update, locale: :en, id: @admin_user,
                       user: attributes_for(:user_with_admin_role, fullname: '')
        expect(response).to render_template :edit
      end
    end
  end

  context 'DELETE#destroy' do
    before :each do
      @admin_user = create(:user_with_admin_role)
      sign_in @admin_user
    end

    it 'deletes the user' do
      expect do
        delete :destroy, locale: :en, id: @admin_user
      end.to change(User, :count).by(-1)
    end

    it 'redirects to users#index' do
      delete :destroy, locale: :en, id: @admin_user
      expect(response).to redirect_to users_en_url
    end
  end

  describe 'user role access' do
    describe 'GET #new' do
      it 'requires login' do
        get :new, locale: :en
        expect(response).to redirect_to new_user_session_en_url
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        user = create(:user_with_user_role)
        get :edit, locale: :en, id: user
        expect(response).to redirect_to new_user_session_en_url
      end
    end

    describe 'GET #create' do
      it 'requires login' do
        post :create, locale: :en, id: create(:user_with_user_role),
                      user: attributes_for(:user_with_user_role)
        expect(response).to redirect_to new_user_session_en_url
      end
    end

    describe 'GET #update' do
      it 'requires login' do
        put :update, locale: :en, id: create(:user_with_user_role),
                     user: attributes_for(:user_with_user_role)
        expect(response).to redirect_to new_user_session_en_url
      end
    end

    describe 'GET #destroy' do
      it 'requires login' do
        delete :destroy, locale: :en, id: create(:user_with_user_role)
        expect(response).to redirect_to new_user_session_en_url
      end
    end
  end

  describe 'editor role access' do
    describe 'GET #edit' do
      it 'requires login' do
        user = create(:user_with_editor_role)
        get :edit, locale: :en, id: user
        expect(response).to redirect_to new_user_session_en_url
      end
    end

    describe 'GET #create' do
      it 'requires login' do
        post :create, locale: :en, id: create(:user_with_editor_role),
                      user: attributes_for(:user_with_editor_role)
        expect(response).to redirect_to new_user_session_en_url
      end
    end

    describe 'GET #update' do
      it 'requires login' do
        put :update, locale: :en, id: create(:user_with_editor_role),
                     user: attributes_for(:user_with_editor_role)
        expect(response).to redirect_to new_user_session_en_url
      end
    end

    describe 'GET #destroy' do
      it 'requires login' do
        delete :destroy, locale: :en, id: create(:user_with_editor_role)
        expect(response).to redirect_to new_user_session_en_url
      end
    end
  end
end
