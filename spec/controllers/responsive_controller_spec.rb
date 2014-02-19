require 'spec_helper'

describe ResponsiveController do
  let(:previous_page) { 'where_i_came_from' }
  before { request.env['HTTP_REFERER'] = previous_page }

  describe 'GET opt_out' do

    it 'redirects back to the referring page' do
      get :opt_out

      expect(response).to redirect_to previous_page
    end

    it 'sets the opt-out cookie' do
      expect(cookies.permanent.signed).to receive(:[]=).with(:roptout, 0)

      get :opt_out
    end
  end
end
