Given(/^I read an article belonging to a single category$/) do
  browse_to_article article
end

Given(/^I read an action plan belonging to a single category$/) do
  browse_to_action_plan action_plan
end

Given(/^I read an action plan belonging to multiple categories$/) do
  browse_to_action_plan action_plan_in_multiple_categories
end

Given(/^I read a static page$/) do
  static_page.load(locale: 'en', id: 'privacy')
end

Given(/^I read a non-navigational category$/) do
  browse_to_category(non_navigational_category, 'en')
end

Given(/^I read a category$/) do
  browse_to_category(category, 'en')
end

Given(/^I read an article belonging to multiple categories$/) do
  browse_to_article article_with_multiple_parents
end

Given(/^I read an orphaned article$/) do
  browse_to_article orphan_article
end

Given(/^I read an orphaned action plan$/) do
  browse_to_action_plan orphan_action_plan
end

Given(/^I read the news page$/) do
  step 'I visit the news page in English'
end

Then(/^I can see breadcrumbs for the article$/) do
  expect(article_page.breadcrumbs.text).to eq(current_article.context)
end

Then(/^I can see breadcrumbs for the action plan$/) do
  expect(action_plan_page.breadcrumbs.text).to eq(current_action_plan.context)
end

Then(/^I can see breadcrumbs for the static page$/) do
  expect(static_page.breadcrumbs.text).to eq('Home')
end

Then(/^I can see breadcrumbs for the category$/) do
  expect(category_page.breadcrumbs.text).to eq(current_category.context)
end

Then(/^I can see that the article appears in those categories$/) do
  expect(article_page.breadcrumbs.text).to eq(current_article.context)
end

Then(/^I can see that the action plan appears in those categories$/) do
  expect(action_plan_page.breadcrumbs.text).to eq(current_action_plan.context)
end

Then(/^I can see breadcrumbs for the news page$/) do
  expect(news_page.breadcrumbs.text).to eq('Home')
end
