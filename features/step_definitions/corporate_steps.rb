
When(/^I visit the corporate page$/) do
  corporate_page.load(locale: 'en')
end

Then(/^I should be informed that I am on the correct page$/) do
  expect(page).to have_content(I18n.t('corporate_home.title', locale: 'en'))
end
