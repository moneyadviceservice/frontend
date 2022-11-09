RSpec.feature 'Stamp duty calculator banners' do
  scenario 'Calculators and their banners are shown/hidden' do
    allow_any_instance_of(ApplicationController).to receive(:syndicated_tool_request?).and_return(true)

    visit '/en/tools/house-buying/stamp-duty-calculator'
    expect(page).to have_no_css('.global-alert--warning')

    visit '/en/tools/house-buying/land-and-buildings-transaction-tax-calculator-scotland'
    expect(page).to have_no_css('.global-alert--warning')

    visit '/en/tools/house-buying/land-transaction-tax-calculator-wales'
    expect(page).to have_no_css('.global-alert--warning')
  end
end
