require 'spec_helper'

describe 'shared/_header' do
  before do
    controller.extend(Localisation)
    allow(template).to receive(:category_navigation)
  end

  context 'when the dont_show_search_box flag is set' do
    before do
      assign(:dont_show_search_box, true)
    end

    it 'does not show the search box' do
      render
      expect(rendered).to_not include 'search-box'
    end
  end

  context 'when the dont_show_search_box flag is not set' do
    it 'shows the search box' do
      render
      expect(rendered).to include 'search-box'
    end
  end
end
