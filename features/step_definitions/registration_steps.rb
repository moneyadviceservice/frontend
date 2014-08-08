When(/^I attempt to register$/) do
  sign_up_page.load(locale: 'en')
end

When(/^I register$/) do
  sign_up_page.load(locale: 'en')
  sign_up_page.first_name.set "phil"
  sign_up_page.email.set "phil@example.com"
  sign_up_page.password.set "password"
  sign_up_page.post_code.set "NE1 6EE"
  sign_up_page.newsletter_subscription.set true
  sign_up_page.submit.click
end

When(/^I register from a direct link$/) do
  step "I register"
end

Then(/^My MAS account should (not )?be created$/) do |negated|
  if negated
    expect(User.count).to eql(0)
  else
    expect(User.where(email: 'phil@example.com').
                where(first_name: 'phil').
                where(post_code: 'NE1 6EE').
                where(newsletter_subscription: true).
                count).to eql(1)
  end
end

Then(/^I should be signed in$/) do
  expect(page.html).to include('My Account')
end

Then(/^I should (?:be|remain) signed out$/) do
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
  sign_up_page.load(locale: 'en')
  sign_up_page.email.set "invalidemail"
  sign_up_page.password.set "password"
  sign_up_page.submit.click
end

Then(/^I should receive a invalid email validation error$/) do
  expect(page.html).to include("Please double-check for the following errors:")
end

When(/^I attempt to register with insecure password$/) do
  sign_up_page.load(locale: 'en')
  sign_up_page.email.set "poor_password@example.com"
  sign_up_page.password.set "abc"
  sign_up_page.submit.click
end

Then(/^I should receive a insecure password validation error$/) do
  expect(page.html).to include("Password is too short")
end

