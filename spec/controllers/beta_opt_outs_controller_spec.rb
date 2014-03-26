require 'spec_helper'

describe BetaOptOutsController do
  let(:previous_page) { 'where_i_came_from' }

  describe 'POST create' do

    it 'redirect to home page' do
      post :create

      expect(response).to redirect_to(root_path(locale: :en))
    end

    it 'sets the opt-in cookie to 0' do
      expect(cookies.permanent).to receive(:[]=).with('roptin', 0)

      post :create
    end

    context 'when redirection page is specified' do
      it 'redirects back to the referring page' do
        post :create, redirection_page: previous_page

        expect(response).to redirect_to(previous_page)
      end
    end
  end

  describe 'DELETE destroy' do
    before { request.env["HTTP_REFERER"] = previous_page }

    context 'via a standard post' do
      it 'sets the dismiss beta opt in cookie to 0' do
        expect(cookies.permanent).to receive(:[]=).with('dismiss_opt_out', 'y')

        post :destroy
      end

      it 'redirects back to the referring page' do
        post :destroy

        expect(response).to redirect_to(previous_page)
      end
    end

    context 'via a standard post' do
      it 'sets the dismiss beta opt in cookie to 0' do
        expect(cookies.permanent).to receive(:[]=).with('dismiss_opt_out', 'y')

        xhr :post, :destroy
      end

      it 'returns a 200' do
        xhr :post, :destroy

        expect(response).to be_success
      end

      it 'returns no body' do
        xhr :post, :destroy

        expect(response.body).to be_blank
      end
    end
  end
end
