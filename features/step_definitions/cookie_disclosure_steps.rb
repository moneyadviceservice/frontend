Given(/^I have not previously acknowledged the cookie message$/) do
  case Capybara.current_driver
  when :rack_test
    page.driver.browser.clear_cookies
  when :poltergeist
    page.driver.remove_cookie('_cookie_notice')
  end
end

Given(/^I have previously acknowledged the cookie message$/) do
  case Capybara.current_driver
  when :rack_test
    page.driver.browser.set_cookie('_cookie_notice=y')
  when :poltergeist
    page.driver.set_cookie('_cookie_notice', 'y')
  end
end

When(/^I visit the website$/) do
  home_page.load
end

Then(/^I should see the cookie message$/) do
  expect(current_page).to have_footer_cookie_message
end

Then(/^I should not see the cookie message$/) do
  expect(current_page).to have_no_footer_cookie_message
end

Then(/^I can acknowledge I understand$/) do
  expect(current_page.footer_cookie_message).to have_close_button
end

Given(/^I visit the site and see the cookie message$/) do
  step "I visit the website"
  step "I should see the cookie message"
end

Given(/^I visit the site and acknowledge the cookie message$/) do
  step "I visit the website"
  step "I close the cookie message"
end

When(/^I visit another page$/) do
  current_page.footer_primary.partners_link.click
end

When(/^I close the cookie message$/) do
  current_page.footer_cookie_message.close_button.click
end

When(/^I click on the "Cookie Policy" link in the footer$/) do
  current_page.footer_secondary.cookie_guide_link.click
end
