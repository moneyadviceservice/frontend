Given(/^I am on the Money Navigator tool landing page$/) do
  money_navigator_page.load
end

When("I choose to start the process") do
  money_navigator_page.get_started.click
end

When("I give default answers to all the questions") do
  money_navigator_questionnaire_page.submit.click
end

Then("I should see results on the Money Navigator tool results page") do
  expect(page.current_path).to eql('/en/tools/money-navigator-tool/results')
end

