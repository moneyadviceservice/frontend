Given(/^I have not previously opted out of the beta$/) do
  case Capybara.current_driver
  when :rack_test
    page.driver.browser.clear_cookies
  when :poltergeist
    page.driver.remove_cookie('roptin')
  end
end

When(/^I opt out of the beta$/) do
  current_page.footer_secondary.opt_out_button.click
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
