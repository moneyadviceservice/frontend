Given(/^I am on an article page$/) do
  step 'I view an article in English'
end

When(/^I scroll to the bottom of the page$/) do
  page.execute_script "window.scrollBy(0,10000)"
end

Then(/^I should see a sticky newsletter sign up form$/) do
  expect(home_page).to have_sticky_newsletter
end

When(/^I dismiss the newsletter$/) do
  home_page.sticky_newsletter.close_button.trigger('click')
  page.driver.set_cookie('_cookie_dismiss_newsletter', 'hide')
end

Then(/^I should not see it again for another month$/) do
  step 'the user should no longer see the newsletter form'
end

When(/^user subscribes to receive newsletters$/) do
  allow_any_instance_of(Core::NewsletterSubscriptionCreator).to receive(:call).and_return( true )

  article_page.sticky_newsletter.subscription_email.set 'test@example.com'
  article_page.sticky_newsletter.send_me_money_advice.click
  page.driver.browser.set_cookie('_cookie_submit_newsletter = hide')
  expect(page).to have_content I18n.t('newsletter_subscriptions.success')
end

Then(/^the user should no longer see the newsletter form$/) do
  step 'I visit the website'
  expect(home_page).to have_no_sticky_newsletter
end
