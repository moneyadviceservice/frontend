When(/^I click on "My Account"$/) do
  account_page.my_account_link.click
end

Then(/^I( don't)? see my account page$/) do |negated|
  if negated
    expect(account_page).to_not be_displayed
  else
    expect(account_page).to be_displayed
  end
end

