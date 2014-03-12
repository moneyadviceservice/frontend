Given(/^I have no cookies stored$/) do
  page.driver.browser.clear_cookies
end

Given(/^I have a persistent cookie notice stored$/) do
  page.driver.browser.set_cookie('_cookie_notice=y')
end

When(/^I close the cookie message$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I have a year old persistent cookie notice stored$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I click on the "(.*?)" link in the footer$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
