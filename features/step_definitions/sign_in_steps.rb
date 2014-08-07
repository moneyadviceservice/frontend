When(/^I attempt to sign in$/) do
  sign_in_page.load
end

Then(/^I am told that the functionality is not implemented$/) do
  expect(status_code).to eql(501)
end


When(/^I sign in$/) do
  email = 'testing@man.net'
  password = 'secretpass'
  User.new(:email => email, :password => password, :password_confirmation => password).save!
  sign_in_page.load(locale: 'en')
  sign_in_page.email.set email
  sign_in_page.password.set password
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

Given(/^I am signed in$/) do
  step "I sign in"
end

When(/^I sign out$/) do
  article_page.sign_out.click
end

