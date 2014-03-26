require_relative '../spec_helper'

describe HomeController do
  describe 'GET show' do
    specify do
      get :show

      expect(response).to be_ok
    end
  end

  describe 'home redirection' do

    before do
      request.env['REQUEST_URI'] = params
      get :show
    end

    context 'when locale param is set to en' do
      let(:params) { '/?locale=en' }
      it 'sets the locale to the specified' do
        expect(response).to redirect_to('/')
      end
    end

    context 'when locale param is set to en' do
      let(:params) { '/?locale=cy' }
      it 'sets the locale to the specified' do
        expect(response).to redirect_to('/cy')
      end
    end
  end
end
