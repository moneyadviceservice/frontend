When(/^I (?:am on|try to view) the settings page$/) do
  settings_page.load(locale: 'en')
end

When(/^I update my first name to "(.*?)"$/) do |first_name|
  settings_page.first_name.set first_name
  settings_page.current_password.set @user.password
  settings_page.submit.click
end

When(/^I update my email address to "(.*?)"$/) do |email|
  settings_page.email.set email
  settings_page.current_password.set @user.password
  settings_page.submit.click
end

When(/^I update password to "(.*?)"$/) do |password|
  settings_page.password.set password
  settings_page.password_confirmation.set password
  settings_page.current_password.set @user.password
  settings_page.submit.click
end

When(/^I update post code to "(.*?)"$/) do |post_code|
  settings_page.post_code.set post_code
  settings_page.current_password.set @user.password
  settings_page.submit.click
end

Then(/^I should see a successful update notification$/) do
  expect(page.html).to include(I18n.t('devise.registrations.updated', locale: 'en'))
end

Then(/^I see my settings page$/) do
  expect(settings_page).to be_displayed
end
