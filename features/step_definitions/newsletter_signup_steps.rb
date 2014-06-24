Then(/^I should see a newsletter sign up form$/) do
  expect(current_page).to have_newsletter
end

When(/^I sign up to the newsletter with a valid email address$/) do
  current_page.newsletter.email.set 'clark.kent@gmail.com'
  current_page.newsletter.signup.click
end

When(/^I sign up to the newsletter with an invalid email address$/) do
  current_page.newsletter.email.set 'clark.kent@dailyplanet'
  current_page.newsletter.signup.click
end

Then(/^I should see a message that my subscription was successful$/) do
  expect(current_page.newsletter).to have_text(I18n.t('newsletter.subscription.success'))
end

Then(/^I should see an error message describing why my subscription failed$/) do
  expect(current_page.newsletter).to have_text(I18n.t('newsletter.subscription.error'))
end
