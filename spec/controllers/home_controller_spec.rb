require_relative '../spec_helper'

describe HomeController, :type => :controller do
  describe 'GET show' do
    specify do
      get :show, locale: :en

      expect(response).to be_ok
    end
  end
end
