require 'rails_helper'

RSpec.describe ErrorsController, type: :controller do
  context 'GET #show' do
    it 'renders the 404 template' do
      get :show, code: '404'
      expect(response).to render_template '404'
    end

    it 'renders the 422 template' do
      get :show, code: '422'
      expect(response).to render_template '422'
    end

    it 'renders the 500 template' do
      get :show, code: '500'
      expect(response).to render_template '500'
    end
  end
end
