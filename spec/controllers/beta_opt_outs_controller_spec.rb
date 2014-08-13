RSpec.describe BetaOptOutsController, :type => :controller do
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
end
