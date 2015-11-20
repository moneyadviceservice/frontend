Given(/^a registered MAS user$/) do
  step 'I register'
end

Given(/^that I am on the user account edit settings page in "(.*?)"$/) do |language|
  visit "/#{language_to_locale(language)}/users/edit"

  expect(page).to have_content(I18n.t('authentication.settings.title'))
end

When(/^I fill in the contact number$/) do
  within('.l-registration') do
    fill_in 'user_contact_number', with: '03005000789'
    fill_in 'user_current_password', with: 'password'
  end

  click_on I18n.t('authentication.settings.label')
end

When(/^I check the research preference box$/) do
  within('.l-registration') do
    check 'user_opt_in_for_research'
    fill_in 'user_current_password', with: 'password'
  end

  click_on I18n.t('authentication.settings.label')
end

Then(/^I should be able to update my user account$/) do
  expect(page).to have_text(I18n.t 'devise.registrations.updated')
end
