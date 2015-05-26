When(/^I visit a corporate tool page$/) do
  corporate_tool_page.load(locale: 'en')
end

When(/^I fill out my organisation name$/) do
  corporate_tool_page.organisation_name.set 'Fake Org'
end

When(/^I fill out my organisation email$/) do
  corporate_tool_page.organisation_email.set 'fakeorg@fakeemail.com'
end

When(/^I specify the language I want the tool in$/) do
  corporate_tool_page.tool_language.set 'en'
end

When(/^I specify the width of the tool$/) do
  corporate_tool_page.tool_width_unit.set 'px'
  corporate_tool_page.tool_width.set '500'
end

When(/^I request for the embded code$/) do
  corporate_tool_page.submit.click
end

Then(/^I should be presented with the embed code$/) do
  expect(page).to have_css('pre.code')
end

Then(/^I should see a successful confirmation of my details submitted$/) do
  expect(page).to have_content('Thanks for partnering with us')
end

Then(/^I should be on the corporate tool page$/) do
  expect(page.current_path).to include('/en/corporate/budget-planner-syndication')
end
