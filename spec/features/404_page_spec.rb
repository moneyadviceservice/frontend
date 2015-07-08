#Feature: 404 page
#
#  Scenario: I visit link that doesn't exist on this site
#      Given that I visit a non-existent link
#          Then I should see a page not found message

RSpec.describe '404 page error', type: :feature do
  context 'page does not exist' do
    it 'shows page not found' do
      visit '/en/bad'
      expect(page).to have_content 'This page can’t be found'
    end

    it 'does not showssu
  end
end
