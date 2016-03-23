When(/^I visit the homepage$/) do
  home_page.load
end

When(/^I view an article$/) do
  browse_to_article article('en')
end

When(/^I visit a category page$/) do
  browse_to_category(category, 'en')
end

Then(/^the main area is immediately after the header$/) do
  expected_element = page.find('.t-default-main-content')
  main_element = page.find('div#main')
  expect(main_element).to eq expected_element
end

Then(/^the main area is at the article content$/) do
  expected_element = page.find('.t-article-main-content')
  main_element = page.find('main#main')
  expect(main_element).to eq expected_element
end

Then(/^the main area is at the categories list$/) do
  expected_element = page.find('.t-category-main-content')
  main_element = page.find('main#main')
  expect(main_element).to eq expected_element
end
