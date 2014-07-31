When(/^I attempt to register$/) do
  sign_up_page.load(locale: 'en')
end

When(/^I register$/) do
  Rails.application.reload_routes!
  Devise.regenerate_helpers!

  sign_up_page.load(locale: 'en')
  sign_up_page.email.set "phil@example.com"
  sign_up_page.password.set "password"
  sign_up_page.password_confirmation.set "password"
  sign_up_page.submit.click
end

When(/^I register from a direct link$/) do
  step "I register"
end

Then(/^My MAS account should be created$/) do
  expect(User.count(email: "phil@example.com")).to eql(1)
end

Then(/^I should be signed in$/) do
  expect(page.html).to include('My Account')
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
