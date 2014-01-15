When(/^I visit the home page$/) do
  home_page.load
end

Then(/^I should see the Money Advice Service brand identity$/) do
  expect(home_page.header.logo).to be_visible
  expect(home_page.footer.logo).to be_visible
end
