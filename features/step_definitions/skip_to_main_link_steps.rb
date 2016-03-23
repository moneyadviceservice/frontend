When(/^I visit the homepage$/) do
  home_page.load
end

When(/^I view an article$/) do
  browse_to_article article('en')
end

When(/^I visit a category page$/) do
  browse_to_category(category, 'en')
end

Then(/^I should be able to skip to the main content$/) do
  expect(page).to have_selector('div#main')
end

Then(/^I should be able to skip to the main article content$/) do
  expect(page).to have_selector('main#main')
end

Then(/^I should be able to skip to the categories list$/) do
  expect(page).to have_selector('main#main')
end
