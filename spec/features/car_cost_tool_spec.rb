RSpec.feature 'Car cost tool' do
  scenario 'Functions after a successful cookie check', vcr: true do
    skip 'Temporarily'

    visit '/en/tools/car-costs-calculator/?checked=true'

    fill_in 'vrm', with: 'AC63 UFO'
    click_on 'Add car'

    expect(page).to have_text('C63 S Premium Plus 2dr 9G-Tronic')
  end
end
