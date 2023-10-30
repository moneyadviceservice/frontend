RSpec.feature 'Car cost tool' do
  scenario 'Yields the decommissioning banner when syndicated' do
    visit '/en/tools/car-costs-calculator'

    expect(page).to have_text('This tool is no longer available')

    visit '/en/tools/car-costs-calculator/a/deep/path'

    expect(page).to have_text('This tool is no longer available')
  end
end
