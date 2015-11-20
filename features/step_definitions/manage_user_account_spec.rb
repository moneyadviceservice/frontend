Given(/^a registered MAS user$/) do
  step 'I register'
end

Given(/^that I am on the user account edit settings page in "(.*?)"$/) do |language|
  settings_page.load(locale: 'en')

  expect(page).to have_content(I18n.t('authentication.settings.title'))
end

When(/^I fill in the contact number$/) do
  settings_page.contact_number.set '03005005000'
  settings_page.current_password.set 'password'

  settings_page.submit.click
end

When(/^I check the research preference box$/) do
  settings_page.opt_in_for_research.set true
  settings_page.current_password.set 'password'

  settings_page.submit.click
end

Then(/^I should be able to update my user account$/) do
  expect(page).to have_text(I18n.t 'devise.registrations.updated')
end
