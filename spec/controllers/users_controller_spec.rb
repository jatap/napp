require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'GET #show' do
    let(:user) { create(:user_with_admin_role) }

    before :each do
      sign_in user
    end

    it "assigns the requested user to @user" do
      get :show, id: user, locale: :en
      expect(assigns(:user)).to eq user
    end

    it "renders the :show template" do
      get :show, id: user, locale: :en
      expect(response).to render_template :show
    end
  end

  context 'GET #new' do
    let(:user) { create(:user_with_admin_role) }

    before :each do
      sign_in user
    end

    it "assigns a new User to @user" do
      get :new, locale: :en
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the :new template" do
      get :new, locale: :en
      expect(response).to render_template :new
    end
  end

  context 'GET#index', js: true do
    let(:user) { create(:user_with_admin_role) }

    before :each do
      sign_in user
    end

    it "renders the :index template" do
      get :index, locale: :en
      expect(response).to render_template :index
    end
  end
end
