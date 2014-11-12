When(/^I attempt to sign in$/) do
  sign_in_page.load(locale: 'en')
end

Then(/^I am told that the functionality is not implemented$/) do
  expect(status_code).to eql(501)
end

When(/^I (?:sign|am signed) in$/) do
  @user = create(:user)
  @user.save!

  sign_in_page.load(locale: 'en')
  sign_in_page.email.set @user.email
  sign_in_page.password.set @user.password
  sign_in_page.submit.click
end

Then(/^I should receive a "(.*?)" notification$/) do |notification|
  expect(page.html).to include(notification)
end

When(/^I attempt to sign in with invalid credentials$/) do
  sign_in_page.load(locale: 'en')

  sign_in_page.email.set 'complete'
  sign_in_page.password.set 'rubbish'
  sign_in_page.submit.click
end

Then(/^I should receive a "(.*?)" validation message$/) do |message|
  expect(page.body).to include(message)
end

When(/^I sign out$/) do
  Rails.application.reload_routes!
  sign_up_page.auth.sign_out.click
end

When(/^I sign in elsewhere$/) do
  Capybara.using_session(:other_session) do
    sign_in_page.load(locale: 'en')
    sign_in_page.email.set @user.email
    sign_in_page.password.set @user.password
    sign_in_page.submit.click
  end
end

Then(/^I should be signed in in both places$/) do
  Capybara.using_session(:other_session) do
    expect(page.html).to include('My Account')
  end

  home_page.load(locale: 'en')
  step 'I should be signed in'
end

Given(/^I have an account$/) do
  step 'I sign in'
  step 'I sign out'
end

Then(/^I click on 'Forgot your password\?'$/) do
  sign_in_page.load(locale: 'en')
  sign_in_page.forgot_password.click
end

Then(/^I should be on a page instructing me of the next steps$/) do
  expect(page.current_path).to eql('/en/users/password/new')
end

When(/^I fill in my email$/) do
  forgot_password_page.load(locale: 'en')
  forgot_password_page.email.set @user.email
  forgot_password_page.submit.click
end

Then(/^I should be able to change my password$/) do
  expect(page.current_path).to include('/en/users/password/edit')
end

Then(/^I should see an email sent notification$/) do
  expect(page.html).to include(I18n.t('devise.passwords.send_instructions', locale: 'en'))
end
