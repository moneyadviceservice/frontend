Given(/^I have not previously dismissed the opt out bar or opted out of the beta$/) do
  case Capybara.current_driver
  when :rack_test
    page.driver.browser.clear_cookies
  when :poltergeist
    page.driver.remove_cookie('roptin')
    page.driver.remove_cookie('dismiss_opt_out')
  end
end

Given(/^I have previously dismissed the opt out bar$/) do
  case Capybara.current_driver
  when :rack_test
    page.driver.browser.set_cookie('dismiss_opt_out=y')
  when :poltergeist
    page.driver.set_cookie('dismiss_opt_out', 'y')
  end
end

Then(/^I should see the opt out bar$/) do
  expect(current_page).to have_opt_out_bar
end

Then(/^I should not see the opt out bar$/) do
  expect(current_page).to have_no_opt_out_bar
end

Then(/^I can choose to dismiss the opt out bar$/) do
  expect(current_page.opt_out_bar).to have_dismiss_button
end

Then(/^I can choose to opt out of the beta$/) do
  expect(current_page.opt_out_bar).to have_opt_out_button
  step 'I should see the opt out footer button'
end

When(/^I dismiss the opt out bar$/) do
  current_page.opt_out_bar.dismiss_button.click
end

When(/^I opt out of the beta via the opt out bar button$/) do
  current_page.opt_out_bar.opt_out_button.click
end

When(/^I opt out of the beta via the footer button$/) do
  current_page.footer_site_links.opt_out_button.click
end

Then(/^I should see the opt out footer button$/) do
  expect(current_page.footer_site_links).to have_opt_out_button
end

When(/^I visit the website and see the opt out bar$/) do
  step 'I visit the website'
  step 'I should see the opt out bar'
end

Given(/^I visit the website and dismiss the opt out bar$/) do
  step 'I visit the website'
  step 'I dismiss the opt out bar'
end

Then(/^the opt out cookie should be set$/) do
  case Capybara.current_driver
  when :rack_test
    rack_test_session = page.driver.browser.current_session
    rack_mock_session = rack_test_session.instance_variable_get(:@rack_mock_session)
    cookie_jar = rack_mock_session.cookie_jar
    expect(cookie_jar['roptin']).to eql('0')
  when :poltergeist
    expect(page.driver.cookies['roptin'].try(:value)).to eql('0')
  end
end
