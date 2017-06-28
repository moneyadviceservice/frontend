Given(/^I am on the Money Manager tool$/) do
  money_manager_page.load
end

Then(/^I complete the series of questions$/) do
  money_manager_page.received_first_payment_true.click
  money_manager_page.single_or_in_couple_single.click
  money_manager_page.submit.click
end

Given(/^I get my results$/) do
  expect(page.current_path).to eql('/en/tools/money-manager/to-read')
end

Then(/^I should not see any hint of my details when I re-visit the tool$/) do
  expect(money_manager_page.received_first_payment_true).not_to be_checked
  expect(money_manager_page.received_first_payment_false).not_to be_checked
end

Then(/^I should be at the Money Manager landing page$/) do
  expect(page.current_path).to eql(money_manager_page.url)
end
