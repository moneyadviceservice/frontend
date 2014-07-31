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

Then(/^My MAS account should be created$/) do
  expect(User.count(email: "phil@example.com")).to eql(1)
end
