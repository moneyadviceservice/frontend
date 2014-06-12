RSpec.describe 'shared/_header', :type => :view do
  before do
    controller.extend(Localisation)

    allow(view).to receive(:display_menu_button_in_header?) { true }
    allow(view).to receive(:display_search_box_in_header?) { display }
  end

  context 'when the search box should be displayed in the header' do
    let(:display) { true }

    it 'is displayed' do
      render

      expect(rendered).to include('search')
    end
  end

  context 'when the search box should NOT be displayed in the header' do
    let(:display) { false }

    it 'is NOT displayed' do
      render

      expect(rendered).to_not include('search')
    end
  end
end
