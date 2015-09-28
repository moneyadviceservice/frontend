When(/^I attempt to register$/) do
  sign_up_page.load(locale: 'en')
end

When(/^I register$/) do
  sign_up_page.load(locale: 'en')
  sign_up_page.first_name.set 'phil'
  sign_up_page.email.set 'phil@example.com'
  sign_up_page.password.set 'password'
  sign_up_page.post_code.set 'NE1 6EE'
  sign_up_page.newsletter_subscription.set true
  sign_up_page.opt_in_for_research.set true
  sign_up_page.contact_number '03005005000'
  sign_up_page.submit.click
end

When(/^I register from a direct link$/) do
  step 'I register'
end

Then(/^My MAS account should (not )?be created$/) do |negated|
  if negated
    expect(User.count).to eql(0)
  else
    expect(User.where(email: 'phil@example.com')
                .where(first_name: 'phil')
                .where(post_code: 'NE1 6EE')
                .where(newsletter_subscription: true)
                .count).to eql(1)
  end
end

Then(/^I should be signed in$/) do
  expect(page).to have_content('My Account')
end

Then(/^I should (?:be|remain) signed out$/) do
  expect(page).to_not have_content('My Account')
end

Then(/^I should be at the home page$/) do
  expect(page.current_path).to eql('/en')
end

Then(/^I should see an "(.*?)" notification$/) do |notification|
  expect(page).to have_content(notification)
end

Then(/^I should be at the page I was on$/) do
  expect(page.current_path).to eql('/en/articles/why-it-pays-to-save-regularly')
end

When(/^I attempt to register with invalid email$/) do
  sign_up_page.load(locale: 'en')
  sign_up_page.email.set 'invalidemail'
  sign_up_page.password.set 'password'
  sign_up_page.submit.click
end

Then(/^I should receive a invalid email validation error$/) do
  expect(page).to have_content('Please double-check for the following errors:')
end

When(/^I attempt to register with insecure password$/) do
  sign_up_page.load(locale: 'en')
  sign_up_page.email.set 'poor_password@example.com'
  sign_up_page.password.set 'abc'
  sign_up_page.submit.click
end

Then(/^I should receive a insecure password validation error$/) do
  expect(page).to have_content('Password is too short')
end

When(/^I attempt to register with an already registered email address$/) do
  step 'I register'
  step 'I sign out'
  step 'I register'
end

Then(/^My MAS account should have already been created$/) do
  expect(User.where(email: 'phil@example.com')
              .where(first_name: 'phil')
              .where(post_code: 'NE1 6EE')
              .where(newsletter_subscription: true)
              .count).to eql(1)
end

Then(/^I should receive an already registered email address validation error$/) do
  expect(page).to have_content('has already been taken')
end

When(/^I attempt to edit my account$/) do
  account_page.load(locale: 'en')
end

When(/^I visit the registration page$/) do
  sign_up_page.load(locale: 'en')
end

Then(/^I should have the option to opt\-in or opt\-out of participating in research$/) do
  expect(sign_up_page.has_opt_in_for_research?).to be true
end

Then(/^I should see the registration benefits$/) do
  expect(sign_up_page).to have_benefits
end

Given(/^I have a registration title set in the session$/) do
  Warden.on_next_request { |proxy| proxy.raw_session['authentication_registration_title'] = 'test.title' }
end

Then(/^I should not see the registration benefits$/) do
  expect(sign_up_page).to_not have_benefits
end

Then(/^the option to participate in marketing research should be checked$/) do
  step 'I should have the option to opt-in or opt-out of participating in research'
  expect(sign_up_page.opt_in_for_research.checked?).to be_truthy
end
