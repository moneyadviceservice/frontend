Given(/^I am on the Money Manager tool$/) do
  money_manager_page.load
end

Given(/^I select a country$/) do
  money_manager_page.get_started.click
end

Given(/^I select a different country$/) do
  money_manager_page.country_select_northern_ireland.set(true)
  money_manager_page.get_started.click
end

When(/^I complete the series of questions$/) do
  step 'I select a country'
  money_manager_questionnaire_page.received_first_payment_true.click
  money_manager_questionnaire_page.single_or_in_couple_single.click
  money_manager_questionnaire_page.submit.click
end

When(/^I answer the questions differently$/) do
  step 'I select a country'
  money_manager_questionnaire_page.received_first_payment_false.click
  money_manager_questionnaire_page.single_or_in_couple_couple.click
  money_manager_questionnaire_page.submit.click
end

Given(/^I get my results$/) do
  expect(page.current_path).to eql('/en/tools/money-manager/to-read')
end

When(/^I visit the show all url$/) do
  money_manager_show_all_advice_page.load
end

Then(/^I should not see any hint of my details when I re-visit the tool$/) do
  step 'I select a country'
  expect(money_manager_questionnaire_page.received_first_payment_true).not_to be_checked
  expect(money_manager_questionnaire_page.received_first_payment_false).not_to be_checked
end

Then(/^I should be at the Money Manager landing page$/) do
  expect(page.current_path).to eql(money_manager_page.url)
end

Then(/^I have the latest answers$/) do
  money_manager_circumstances_changed_page.load
  expect(money_manager_circumstances_changed_page.received_first_payment_false).to be_checked
  expect(money_manager_circumstances_changed_page.single_or_in_couple_couple).to be_checked
end


Then(/^I see all of the advice$/) do
  all_advice_count = money_manager_show_all_advice_page.all_advice_list_items.length
  visible_advice_count = money_manager_show_all_advice_page.active_advice_list_items.length
  expect(all_advice_count).to eq(visible_advice_count)
end
