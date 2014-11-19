When(/^I click on "My Account"$/) do
  account_page.my_account_link.click
end

Then(/^I see my account page$/) do
  expect(account_page).to be_displayed
end

