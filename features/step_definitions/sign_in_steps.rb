When(/^I attempt to sign in$/) do
  sign_in_page.load
end

Then(/^I am told that the functionality is not implemented$/) do
  expect(status_code).to eql(501)
end

When(/^I sign in$/) do
  user = User.new(email: 'user@example.com', password: 'password')
  user.save!

  sign_in_page.load(locale: 'en')
  sign_in_page.email.set user.email
  sign_in_page.password.set user.password
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

