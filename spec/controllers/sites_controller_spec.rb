require 'rails_helper'

RSpec.describe SitesController, type: :controller do
  context 'GET #show' do
    let(:site) { create(:site) }

    before :each do
      sign_in create(:user_with_admin_role)
      get :show, id: site, locale: :en
    end

    it 'assigns the requested user to @site' do
      expect(assigns(:site)).to eq site
    end

    it 'renders the :show template' do
      expect(response).to render_template :show
    end

    it 'decorates object instance' do
      expect(assigns(:site)).to be_decorated
    end
  end

  context 'GET #edit' do
    let(:site) { create(:site) }

    it 'requires admin role' do
      sign_in create(:user_with_admin_role)
      get :edit, locale: :en, id: site

      expect(response).to have_http_status 200
    end

    it 'fails with other roles' do
      user   = create(:user_with_user_role)
      sign_in user
      get :edit, locale: :en, id: site

      expect(response).to redirect_to root_url
    end
  end

  context 'PATCH#update' do
    let(:site) { create(:site) }

    before :each do
      @admin_user = create(:user_with_admin_role)
      sign_in @admin_user
    end

    context 'valid attributes' do
      it 'locates the requested @site' do
        patch :update, locale: :en, id: site,
                       site: attributes_for(:site)
        expect(assigns(:site)).to eq(site)
      end

      it "changes @site's attributes" do
        patch :update, locale: :en, id: site,
                       site: attributes_for(:site,
                                            name: 'Mister Bean Site')
        site.reload
        expect(site.name).to eq('Mister Bean Site')
      end

      it 'redirects to the updated site show page' do
        patch :update, locale: :en, id: site,
                       site: attributes_for(:site)
        expect(response).to redirect_to site_en_path
      end
    end

    describe 'with invalid attributes' do
      it "does not change the site's attributes" do
        name = site.name
        patch :update, locale: :en, id: site,
                       site: attributes_for(:site, name: '')
        site.reload
        expect(site.name).to eq(name)
      end

      it 're-renders the :edit template' do
        patch :update, locale: :en, id: site,
                       site: attributes_for(:site, name: '')
        expect(response).to render_template :edit
      end
    end
  end
end
