RSpec.describe 'errors/show', type: :view do
  before { allow(view).to receive(:category_navigation) { {} } }

  context 'a not found error' do
    before { assign(:rescue_response, :not_found) }

    it 'displays an error message' do
      render

      expect(rendered).to match(/This page can’t be found/)
    end
  end
end
