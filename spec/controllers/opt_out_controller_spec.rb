require 'spec_helper'

describe OptOutController do
  let(:previous_page) { 'where_i_came_from' }
  before { request.env['HTTP_REFERER'] = previous_page }

  describe 'POST create' do

    it 'redirects back to the referring page' do
      post :create

      expect(response).to redirect_to previous_page
    end

    it 'set the opt-int cookie to 0' do
      expect(cookies.permanent.signed).to receive(:[]=).with(:roptin, 0)

      post :create
    end
  end
end
