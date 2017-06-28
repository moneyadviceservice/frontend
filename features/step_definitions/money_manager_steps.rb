Given(/^I am on the Money Manager tool$/) do
  visit('/en/tools/money-manager/')
end

Then(/^I complete the series of questions$/) do
  find_field(id: 'questionnaire_received_first_payment_true').click
  find_field(id: 'questionnaire_single_or_in_couple_single').click
  click_button('Submit')
end

Given(/^I get my results$/) do
  expect(page.current_path).to eql('/en/tools/money-manager/to-read')
end

Then(/^I should not see any hint of my details when I re-visit the tool$/) do
  expect(find_field(id: 'questionnaire_received_first_payment_true')).not_to be_checked
  expect(find_field(id: 'questionnaire_received_first_payment_false')).not_to be_checked
end

Then(/^I should be at the Money Manager landing page$/) do
  expect(page.current_path).to eql('/en/tools/money-manager/')
end
