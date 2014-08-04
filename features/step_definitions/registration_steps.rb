When(/^I attempt to register$/) do
  sign_up_page.load(locale: 'en')
end

When(/^I register$/) do
  Rails.application.reload_routes!
  Devise.regenerate_helpers!

  sign_up_page.load(locale: 'en')
  sign_up_page.first_name.set "phil"
  sign_up_page.email.set "phil@example.com"
  sign_up_page.password.set "password"
  sign_up_page.password_confirmation.set "password"
  sign_up_page.post_code.set "NE1 6EE"
  sign_up_page.submit.click
end

When(/^I register from a direct link$/) do
  step "I register"
end

Then(/^My MAS account should (not )?be created$/) do |negated|
  if negated
    expect(User.count).to eql(0)
  else
    expect(User.count).to eql(1)
  end
end

Then(/^I should be signed in$/) do
  expect(page.html).to include('My Account')
end

Then(/^I should remain signed out$/) do
  expect(page.html).to_not include('My Account')
end

Then(/^I should be at the home page$/) do
  expect(page.current_path).to eql('/en')
end

Then(/^I should see an "(.*?)" notification$/) do |notification|
  expect(page.html).to include(notification)
end

Then(/^I should be at the page I was on$/) do
  expect(page.current_path).to eql('/en/articles/why-it-pays-to-save-regularly')
end

When(/^I attempt to register with invalid email$/) do
  Rails.application.reload_routes!
  Devise.regenerate_helpers!

  sign_up_page.load(locale: 'en')
  sign_up_page.email.set "invalidemail"
  sign_up_page.password.set "password"
  sign_up_page.password_confirmation.set "password"
  sign_up_page.submit.click
end

Then(/^I should receive a invalid email validation error$/) do
  expect(page.html).to include("Please double-check for the following errors:")
end
