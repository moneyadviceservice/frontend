require_relative '../spec_helper'

describe HomeController do
  describe 'GET show' do
    specify do
      get :show, locale: :en

      expect(response).to be_ok
    end
  end
end
