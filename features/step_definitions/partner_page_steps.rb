Given(/^I am on the partners page$/) do
  partners_page.load
end

Then(/^the partners page contains the cookie message$/) do
  expect(partners_page).to have_cookie_message
end

When(/^the partners page does not contain the cookie message$/) do
  expect(partners_page).to have_no_cookie_message
end
