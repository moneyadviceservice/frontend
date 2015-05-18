When(/^I visit the corporate tool directory page$/) do
  corporate_tool_directory_page.load(locale: 'en')
end

Then(/^I should be presented with the most popular tools$/) do
  expect(corporate_tool_directory_page.popular_tools_heading)
    .to have_content(I18n.t('corporate_tool_directory.popular_tools_heading'))
end

Then(/^I should be presented with a list of all tools available$/) do
  expect(corporate_tool_directory_page.all_tools_heading)
    .to have_content(I18n.t('corporate_tool_directory.all_tools_heading'))
end

Then(/^I should be on the corporate tool directory$/) do
  expect(page.current_path).to include('/en/corporate/syndication')
end
