RSpec.feature 'Universal credit tool' do
  scenario 'Yields the decommissioning banner when syndicated' do
    visit '/en/tools/money-manager'

    expect(page).to have_text('This tool is no longer available')

    visit '/en/tools/money-manager/a/deep/path'

    expect(page).to have_text('This tool is no longer available')
  end
end
