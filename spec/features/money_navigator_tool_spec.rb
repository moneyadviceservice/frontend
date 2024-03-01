RSpec.feature 'Money navigator tool' do
  scenario 'Yields the decommissioning banner when syndicated' do
    visit '/en/tools/money-navigator-tool'

    expect(page).to have_text('This tool is no longer available')

    visit '/en/tools/money-navigator-tool/a/deep/path'

    expect(page).to have_text('This tool is no longer available')
  end
end
